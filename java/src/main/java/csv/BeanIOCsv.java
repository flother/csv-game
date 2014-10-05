package csv;

import java.io.*;
import org.beanio.stream.csv.CsvReader;

public class BeanIOCsv
{
    public static void main( String[] args )
    {
        try {
            CsvReader reader = new CsvReader(new FileReader("/dev/stdin"));

            String [] nextLine;
            int sum = 0;
            while ((nextLine = reader.read()) != null) {
                sum += nextLine.length;
            }
            System.out.println(sum);
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        }
    }
}
