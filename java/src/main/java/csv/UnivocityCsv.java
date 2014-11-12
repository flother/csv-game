package csv;

import java.io.*;

import com.univocity.parsers.common.*;
import com.univocity.parsers.common.processor.*;
import com.univocity.parsers.csv.*;

public class UnivocityCsv
{
    public static void main( String[] args )
    {
        try {
            CsvParserSettings settings = new CsvParserSettings();

            //turning off features enabled by default
            settings.setIgnoreLeadingWhitespaces(false);
            settings.setIgnoreTrailingWhitespaces(false);
            settings.setSkipEmptyLines(false);
            settings.setColumnReorderingEnabled(false);

            settings.setRowProcessor(new AbstractRowProcessor() {

                @Override
                public void processEnded(ParsingContext context){
                    System.out.println(context.currentRecord());
                }
            });

            CsvParser parser = new CsvParser(settings);
            parser.parse(new FileReader("/dev/stdin"));
        } catch (FileNotFoundException e) {
        }
    }
}
