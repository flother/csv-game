{-# LANGUAGE BangPatterns, ScopedTypeVariables #-}

import Control.Monad
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString as B
import Data.Csv.Streaming
import Data.Text

import System.Exit
import System.IO

loop !acc (Nil message _) = case message of 
                                Just m -> putStrLn m >> exitFailure
                                _      -> putStrLn (show acc) >> exitSuccess
loop !acc (Cons (Right record) records) = {-# SCC "accumulationOK" #-} loop (acc + countFields record) records
loop !acc (Cons (Left _) records) = loop acc records

countFields :: [a] -> Int
countFields xs = {-# SCC "length" #-} Prelude.length xs
{-# INLINE countFields #-}

main :: IO ()
main = do
    csvData <- BL.readFile "/dev/stdin" 


    loop 0 (decode NoHeader csvData :: Records [B.ByteString]) 
