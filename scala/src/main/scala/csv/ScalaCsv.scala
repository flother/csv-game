import com.bizo.mighty.csv.CSVReader

object ScalaCsv{

  def main(args: Array[String]) {
    var sum = 0
    CSVReader("/dev/stdin").foreach(sum+= _.length)
    println(sum)
  }
  }
