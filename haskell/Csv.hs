{-# LANGUAGE BangPatterns, ScopedTypeVariables, NoMonomorphismRestriction #-}
 -- Using Cassava from: https://hackage.haskell.org/package/cassava
import Control.Monad
import qualified Data.ByteString as B
import Data.Csv.Incremental
import Data.Text
import System.Exit
import System.IO


main :: IO ()
main = withFile "/dev/stdin" ReadMode $ \ csvFile -> do
    let loop !_ (Fail _ errMsg) = putStrLn errMsg >> exitFailure
        loop !acc (Many rs k) = loop (acc + countFields rs) =<< feed k
        loop !acc (Done rs) = putStrLn $ show (countFields rs + acc)

        feed k = do
            isEof <- hIsEOF csvFile
            if isEof
                then return $ k B.empty
                else k `fmap` B.hGetSome csvFile 4096
    loop 0 (decode NoHeader :: Parser [Data.Text.Text])
  where
    countFields :: [Either String [a]] -> Int
    countFields rs = sum $ Prelude.map (\fs -> case fs of 
                                                Right fs' -> Prelude.length fs'
                                                Left _    -> 0) rs
