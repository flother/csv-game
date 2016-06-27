package csv;

import java.io.*;
import com.univocity.parsers.csv.*;

public class UnivocityCsvCount
{
    public static void main( String[] args )
    {
        try {
            CsvParserSettings settings = new CsvParserSettings();
            CsvParser reader = new CsvParser(settings);
            final int field = Integer.parseInt(args[0]) - 1; 
            reader.beginParsing(new FileReader(args[1]));

            String [] nextLine;
            int sum = 0;
            while ((nextLine = reader.parseNext()) != null) {
                sum += Integer.parseInt(nextLine[field]);
            }
            System.out.println(sum);
        } catch (FileNotFoundException e) {
        }
    }
}
