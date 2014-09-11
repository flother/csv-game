{-# LANGUAGE BangPatterns, ScopedTypeVariables #-}

import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString as B
import Data.Csv.Streaming
import qualified Data.Foldable as F

import System.Exit
import System.IO

getFieldCount csv = F.foldl' count 0 (decode NoHeader csv :: Records [B.ByteString])
  where
    count :: Int -> [a] -> Int
    count acc fs = acc + (Prelude.length fs)
    {-# INLINE count #-}

main :: IO ()
main = do
    csvData <- BL.readFile "/dev/stdin"
    putStrLn . show $ getFieldCount csvData

