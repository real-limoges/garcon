{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module Garcon.API (API, ParseRequest (..), api) where

import Data.Aeson (FromJSON)
import Data.Text (Text)
import GHC.Generics (Generic)
import Servant

import Chompsky.Types (Extraction, ProcessTrace)

newtype ParseRequest = ParseRequest {text :: Text}
    deriving (Show, Eq, Generic)
    deriving anyclass (FromJSON)

type HealthAPI = "health" :> Get '[JSON] String

type ParseAPI =
    "parse" :> ReqBody '[JSON] ParseRequest :> Post '[JSON] Extraction
        :<|> "parse" :> "trace" :> ReqBody '[JSON] ParseRequest :> Post '[JSON] ProcessTrace

type API = HealthAPI :<|> ParseAPI

api :: Proxy API
api = Proxy
