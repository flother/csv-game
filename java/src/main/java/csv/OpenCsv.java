package csv;

import java.io.*;
import au.com.bytecode.opencsv.CSVReader;

public class OpenCsv
{
    public static void main( String[] args )
    {
        try {
            CSVReader reader = new CSVReader(new FileReader("/dev/stdin"));
            String [] nextLine;
            int sum = 0;
            while ((nextLine = reader.readNext()) != null) {
                sum += nextLine.length;
            }
            System.out.println(sum);
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        }
    }
}
