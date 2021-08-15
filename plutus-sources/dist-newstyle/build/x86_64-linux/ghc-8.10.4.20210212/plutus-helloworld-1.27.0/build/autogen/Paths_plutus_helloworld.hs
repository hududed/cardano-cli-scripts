{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_plutus_helloworld (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
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
version = Version [1,27,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/hud/.cabal/bin"
libdir     = "/home/hud/.cabal/lib/x86_64-linux-ghc-8.10.4.20210212/plutus-helloworld-1.27.0-inplace"
dynlibdir  = "/home/hud/.cabal/lib/x86_64-linux-ghc-8.10.4.20210212"
datadir    = "/home/hud/.cabal/share/x86_64-linux-ghc-8.10.4.20210212/plutus-helloworld-1.27.0"
libexecdir = "/home/hud/.cabal/libexec/x86_64-linux-ghc-8.10.4.20210212/plutus-helloworld-1.27.0"
sysconfdir = "/home/hud/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "plutus_helloworld_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "plutus_helloworld_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "plutus_helloworld_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "plutus_helloworld_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "plutus_helloworld_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "plutus_helloworld_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
