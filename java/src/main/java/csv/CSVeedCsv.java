package csv;

import java.io.*;
import org.csveed.api.*;

public class CSVeedCsv 
{
    public static void main( String[] args )
    {
        try {
            CsvClient<Row> reader = new CsvClientImpl<Row>(new FileReader("/dev/stdin"));
            reader.setUseHeader(false);
            reader.setSeparator(',');
            Row nextLine;
            int sum = 0;
            while ((nextLine = reader.readRow()) != null) {
                sum += nextLine.size();
            }
            System.out.println(sum);
        } catch (FileNotFoundException e) {
        }
    }
}
