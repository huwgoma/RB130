# numbers = '1, 2, 3, and 4'

# numbers.split(', ')
# #=> ['1', '2', '3', 'and 4']
# numbers.split(/, (and )?/)
# #=> ['1', '2', '3', 'and ', '4']
# numbers.split(/, (?:and )?/)
# #=> ['1', '2', '3', '4']


url = 'http://launchschool.com'

url.sub(/https?/, 'https')
#=> "https://launchschool.com"


ccn = '1234-5678-9098-7654'

ccn.gsub(/\d{4}-/, '****-')
#=> '****-****-****-7654'

