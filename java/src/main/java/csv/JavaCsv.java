package csv;

import java.io.*;
import com.csvreader.CsvReader;

public class JavaCsv
{
    public static void main( String[] args )
    {
        try {
            CsvReader reader = new CsvReader(new FileReader("/dev/stdin"));
            String [] nextLine;
            int sum = 0;
            while (reader.readRecord()) {
                sum += reader.getColumnCount();
            }
            System.out.println(sum);
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        }
    }
}
