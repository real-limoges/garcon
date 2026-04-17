module Main (main) where

import Data.Maybe (fromMaybe)
import Network.Wai.Handler.Warp (run)
import System.Environment (lookupEnv)

import Chompsky.Config (loadConfig)
import Garcon.App (app)

main :: IO ()
main = do
    cfgDir <- fromMaybe "config" <$> lookupEnv "CHOMPSKY_CONFIG_DIR"
    cfg <- loadConfig cfgDir
    putStrLn "garcon running on port 7444"
    run 7444 (app cfg)
