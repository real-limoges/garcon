{-# LANGUAGE TypeOperators #-}

module Garcon.Server (server) where

import Servant

import Chompsky.Config (AppConfig)
import Chompsky.Pipeline (ProcessResult (..), processRemarkPure, processRemarkTraced)
import Chompsky.Types (Extraction, ProcessTrace)
import Garcon.API (API, ParseRequest (..))

server :: AppConfig -> Server API
server cfg = healthHandler :<|> parseHandler cfg :<|> traceHandler cfg

healthHandler :: Handler String
healthHandler = pure "ok"

parseHandler :: AppConfig -> ParseRequest -> Handler Extraction
parseHandler cfg (ParseRequest t) = pure $ prExtraction (processRemarkPure cfg t)

traceHandler :: AppConfig -> ParseRequest -> Handler ProcessTrace
traceHandler cfg (ParseRequest t) = pure $ processRemarkTraced cfg t
