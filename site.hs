--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
module Main where

import  System.Locale (TimeLocale(..))
import  Data.Functor ((<$>))
import  Data.List (isPrefixOf)
import  Data.Monoid (mappend)
import  Data.Text (pack, unpack, replace, empty)
import  Hakyll

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    -- Build tags
    tags <- buildTags "posts/*" (fromCapture "tags/*.html")

    -- Compress CSS
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    -- Copy fonts
    match "fonts/*" $ do
        route   idRoute
        compile copyFileCompiler

    -- Copy JS files
    match "js/*" $ do
        route   idRoute
        compile copyFileCompiler

    -- Copy design images
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    -- Copy files
    match "files/*" $ do
        route   idRoute
        compile copyFileCompiler

    -- Render posts
    match "posts/*" $ do
        route   $ setExtension ".html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    (tagsCtx tags) 
            
            -- RSS feed
            >>= (externalizeUrls $ feedRoot feedConfiguration)
            >>= saveSnapshot "content"
            >>= (unExternalizeUrls $ feedRoot feedConfiguration)

            >>= loadAndApplyTemplate "templates/disqus.html"  (tagsCtx tags)
            >>= loadAndApplyTemplate "templates/default.html" (tagsCtx tags)
            >>= relativizeUrls
   
    -- Render posts list
    create ["posts.html"] $ do
        route idRoute
        compile $ do
            posts <- loadAll "posts/*"
            sorted <- recentFirst posts
            itemTpl <- loadBody "templates/postitem.html"
            list <- applyTemplateList itemTpl postCtx sorted
            makeItem list
                >>= loadAndApplyTemplate "templates/posts.html"   allPostsCtx
                >>= loadAndApplyTemplate "templates/default.html" allPostsCtx
                >>= relativizeUrls

    -- Render index
    create ["index.html"] $ do
        route idRoute
        compile $ do
            posts <- loadAll "posts/*"
            sorted <- take 5 <$> recentFirst posts
            itemTpl <- loadBody "templates/postitem.html"
            list <- applyTemplateList itemTpl postCtx sorted
            makeItem list
                >>= loadAndApplyTemplate "templates/index.html"   (homeCtx tags list)
                >>= loadAndApplyTemplate "templates/default.html" (homeCtx tags list)
                >>= relativizeUrls

    -- Render related posts list from a specific tag
    tagsRules tags $ \tag pattern -> do
        let title = "Articles à propos de : " ++ tag
        route idRoute
        compile $ do
            list <- postList tags pattern recentFirst
            makeItem ""
                >>= loadAndApplyTemplate "templates/posts.html"
                        (constField "title" title `mappend`
                         constField "body"  list  `mappend`
                         defaultContext)
                >>= loadAndApplyTemplate "templates/default.html"
                        (constField "description" "Liste des articles" `mappend`
                         defaultContext)
                >>= relativizeUrls

    -- Render RSS feed
    create ["rss.xml"] $ do
        route idRoute
        compile $ do
            posts <- loadAllSnapshots "posts/*" "content"
            sorted <- take 10 <$> recentFirst posts
            renderRss feedConfiguration feedCtx (take 10 sorted)

    create ["atom.xml"] $ do
        route idRoute
        compile $ do
            posts <- loadAllSnapshots "posts/*" "content"
            sorted <- take 10 <$> recentFirst posts
            renderAtom feedConfiguration feedCtx (take 10 sorted)

    -- Read templates
    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateFieldWith frTimeLocale "date" "%e %B %Y" `mappend`
    defaultContext


--------------------------------------------------------------------------------
allPostsCtx :: Context String
allPostsCtx =
    constField "title" "Tous les articles" `mappend`
    constField "description" "Liste des articles" `mappend`
    postCtx

--------------------------------------------------------------------------------
homeCtx :: Tags -> String -> Context String
homeCtx tags list =
    constField "posts" list `mappend`
    constField "title" "Accueil" `mappend`
    constField "description" "Articles que j'écris sur les thèmes de l'électronique et de l'informatique" `mappend`
    field "taglist" (\_ -> renderTagList tags) `mappend`
    defaultContext

--------------------------------------------------------------------------------
feedCtx :: Context String
feedCtx =
    bodyField "description" `mappend`
    postCtx

--------------------------------------------------------------------------------
tagsCtx :: Tags -> Context String
tagsCtx tags =
    tagsField "prettytags" tags `mappend`
    postCtx
 
--------------------------------------------------------------------------------
feedConfiguration :: FeedConfiguration
feedConfiguration = FeedConfiguration
    { feedTitle       = "David Guyon - blog"
    , feedDescription = "Articles que j'écris"
    , feedAuthorName  = "David Guyon"
    , feedAuthorEmail = "david@guyon.me"
    , feedRoot        = "http://blog.david.guyon.me"
    }

--------------------------------------------------------------------------------
externalizeUrls :: String -> Item String -> Compiler (Item String)
externalizeUrls root item = return $ fmap (externalizeUrlsWith root) item

externalizeUrlsWith :: String -- ^ Path to the site root
                    -> String -- ^ HTML to externalize
                    -> String -- ^ Resulting HTML
externalizeUrlsWith root = withUrls ext
  where
    ext x = if isExternal x then x else root ++ x

--------------------------------------------------------------------------------
unExternalizeUrls :: String -> Item String -> Compiler (Item String)
unExternalizeUrls root item = return $ fmap (unExternalizeUrlsWith root) item

unExternalizeUrlsWith :: String -- ^ Path to the site root
                      -> String -- ^ HTML to unExternalize
                      -> String -- ^ Resulting HTML
unExternalizeUrlsWith root = withUrls unExt
  where
    unExt x = if root `isPrefixOf` x then unpack $ replace (pack root) empty (pack x) else x

--------------------------------------------------------------------------------
postList :: Tags
          -> Pattern
          -> ([Item String] -> Compiler [Item String])
          -> Compiler String
postList tags pattern preprocess' = do
    postItemTpl <- loadBody "templates/postitem.html"
    posts <- loadAll pattern
    processed <- preprocess' posts
    applyTemplateList postItemTpl (tagsCtx tags) processed

--------------------------------------------------------------------------------
frTimeLocale :: TimeLocale 
frTimeLocale =  TimeLocale { 
  wDays  = [("dimanche", "dim"), ("lundi",    "lun"), 
            ("mardi",    "mar"), ("mercredi", "mer"), 
            ("jeudi",    "jeu"), ("vendredi", "ven"), 
            ("samedi",   "sam")], 

  months = [("janvier",   "jan"), ("février",  "fev"), 
            ("mars",      "mar"), ("avril",    "avr"), 
            ("mai",       "mai"), ("juin",    "juin"), 
            ("juillet",  "juil"), ("août",    "août"), 
            ("septembre", "sep"), ("octobre",  "oct"), 
            ("novembre",  "nov"), ("décembre", "dec")], 

  intervals = [ ("année","années") 
              , ("mois", "mois") 
              , ("jour","jours") 
              , ("heure","heures") 
              , ("min","mins") 
              , ("sec","secs") 
              , ("usec","usecs") 
              ], 
  amPm = (" du matin", " de l'après-midi"), 
  dateTimeFmt = "%a %e %b %Y, %H:%M:%S %Z", 
  dateFmt   = "%d-%m-%Y", 
  timeFmt   = "%H:%M:%S", 
  time12Fmt = "%I:%M:%S %p" 
} 
