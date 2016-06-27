package csv;

import java.io.*;
import au.com.bytecode.opencsv.CSVReader;

public class OpenCsvCount
{
    public static void main( String[] args )
    {
        try {
            final int field = Integer.parseInt(args[0]) - 1;
            CSVReader reader = new CSVReader(new FileReader(args[1]));
            String [] nextLine;
            int sum = 0;
            while ((nextLine = reader.readNext()) != null) {
                sum += Integer.parseInt(nextLine[field]);
            }
            System.out.println(sum);
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        }
    }
}
