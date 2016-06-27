#include <boost/spirit/include/classic_core.hpp>
#include <boost/spirit/include/classic_parser.hpp>
#include <boost/spirit/include/classic_core.hpp>
#include <boost/spirit/include/classic_confix.hpp>
#include <boost/spirit/include/classic_lists.hpp>
#include <boost/spirit/include/classic_escape_char.hpp>
#include <iostream>
#include <string>
#include <functional>

using namespace boost::spirit::classic;

typedef const char *iterator_t;

struct counter : std::binary_function<iterator_t, const iterator_t &,void>
{
    counter(size_t &count)
        : count_(count)
    {}

    size_t &count_;

    void operator()(iterator_t first, iterator_t const &last) const
    {
        count_++;
    }
};


int main()
{
    std::ios_base::sync_with_stdio(false);
    size_t n = 0;
    counter c(n);

    rule<> list_csv, list_csv_item;

    list_csv_item =
        !(
                confix_p('\"', *c_escape_ch_p, '\"')
                | *(anychar_p - ',')
         );

    list_csv =
        list_p(
                list_csv_item[c],
                ','
              )
        ;

    std::string line;
    while (getline(std::cin, line))
        parse(line.c_str(), list_csv);

    std::cout << n << std::endl;
}
