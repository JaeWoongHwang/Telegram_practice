require 'httparty'
require 'awesome_print'
require 'json'
require 'uri'
require 'nokogiri'
# uri는 한글 사용이 가능하게끔 설정
# awesome_print는 루비 코드만 이쁘게 만들어줌
# 루비코드로 바꿔주기 위해 json을 사용
url = "https://api.telegram.org/bot"
token = ENV['TELE_TOKEN']

response = HTTParty.get("#{url}#{token}/getUpdates")
# 괄호안에 있는 코드를 JSON을 통해 루비코드로 변환
hash = JSON.parse(response.body)

chat_id =  hash["result"][0]["message"]["from"]["id"]

# msg = "YOLO"
# Send Kospi
# response = HTTParty.get('http://finance.naver.com/sise/sise_index.nhn?code=KOSPI')
# html = Nokogiri::HTML(response.body)
# kospi = html.css('#now_value').text
#
# msg = "#{kospi}"
# encoded = URI.encode(msg)

# HTTParty.get("#{url}#{token}/sendmessage?chat_id=#{chat_id}&text=#{encoded}")

# Send lotto number
response = HTTParty.get('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=784')
lotto = JSON.parse(response.body)

lucky = []

6.times do |n|
  lucky << lotto["drwtNo#{n+1}"]
end

bonus = lotto["bnusNo"]
winner = lucky.to_s

msg = "Number : #{winner} Bonus number : #{bonus}"
encoded = URI.encode(msg)

HTTParty.get("#{url}#{token}/sendmessage?chat_id=#{chat_id}&text=#{encoded}")

# while true
#   HTTParty.get("#{url}#{token}/sendmessage?chat_id=#{chat_id}&text=#{encoded}")
#   # 괄호 안의 숫자만큼 잠들게 함. 코드가 한번돌고 5초 뒤에 다시 돌고 반복
#   sleep(5)
# end
