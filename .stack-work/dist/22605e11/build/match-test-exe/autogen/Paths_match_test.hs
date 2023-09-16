{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_match_test (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "C:\\Users\\Lenovo\\match-test\\.stack-work\\install\\425523dc\\bin"
libdir     = "C:\\Users\\Lenovo\\match-test\\.stack-work\\install\\425523dc\\lib\\x86_64-windows-ghc-9.4.7\\match-test-0.1.0.0-GnbKNt5mN5CUqfNljiKuF-match-test-exe"
dynlibdir  = "C:\\Users\\Lenovo\\match-test\\.stack-work\\install\\425523dc\\lib\\x86_64-windows-ghc-9.4.7"
datadir    = "C:\\Users\\Lenovo\\match-test\\.stack-work\\install\\425523dc\\share\\x86_64-windows-ghc-9.4.7\\match-test-0.1.0.0"
libexecdir = "C:\\Users\\Lenovo\\match-test\\.stack-work\\install\\425523dc\\libexec\\x86_64-windows-ghc-9.4.7\\match-test-0.1.0.0"
sysconfdir = "C:\\Users\\Lenovo\\match-test\\.stack-work\\install\\425523dc\\etc"

getBinDir     = catchIO (getEnv "match_test_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "match_test_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "match_test_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "match_test_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "match_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "match_test_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
