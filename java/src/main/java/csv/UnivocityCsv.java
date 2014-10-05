package csv;

import java.io.*;
import com.univocity.parsers.csv.*;

public class UnivocityCsv
{
    public static void main( String[] args )
    {
        try {
            CsvParserSettings settings = new CsvParserSettings();
            CsvParser reader = new CsvParser(settings);

            reader.beginParsing(new FileReader("/dev/stdin"));

            String [] nextLine;
            int sum = 0;
            while ((nextLine = reader.parseNext()) != null) {
                sum += nextLine.length;
            }
            System.out.println(sum);
        } catch (FileNotFoundException e) {
        }
    }
}
