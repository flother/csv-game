package csv;

import java.io.*;
import java.nio.charset.*;
import java.util.*;

import org.apache.commons.csv.*;

public class CommonsCsv
{
    public static void main( String[] args )
    {
        try {
            CSVFormat format = CSVFormat.RFC4180;
            Charset charset = Charset.forName("ISO-8859-1");
            CSVParser reader = CSVParser.parse(new File("/dev/stdin"), charset, format);
            int sum = 0;
            for (CSVRecord rec : reader) {
                sum += rec.size();
            }
            System.out.println(sum);
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        }
    }
}
