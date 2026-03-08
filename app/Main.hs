module Main (main) where

import Network.Wai.Handler.Warp (run)

import Garcon.App (app)

main :: IO ()
main = do
    putStrLn "garcon running on port 8080"
    run 8080 app