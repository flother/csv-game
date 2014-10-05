package csv;

import java.io.*;

import com.espertech.esperio.*;
import com.espertech.esperio.csv.*;

public class EspertechCsv
{
    public static void main( String[] args )
    {
        try {
            AdapterInputSource adapterInputSource = new AdapterInputSource(new File("/dev/stdin"));
            CSVReader reader = new CSVReader(adapterInputSource);
            String [] nextLine;
            int sum = 0;
            while ((nextLine = reader.getNextRecord()) != null) {
                sum += nextLine.length;
            }
            System.out.println(sum);
        } catch (IOException e) {
        }
    }
}
