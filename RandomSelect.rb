# coding: utf-8

## ISDLメンバーからランダムに人を選択
## 引数1：all = 全員， u4 = U4のみ， M1 = M1のみ， M2 = M2のみ

U4_EUC  = ["         中原", "        森本し", "         藤本"]                                                    # 3人
U4_MIKI = ["         中村", "        森本り", "         坂東", "         伊藤", "         平井",
           "         神田", "          村野", "         川村", "         岡田", "         新井", "         松倉"] # 11人
M1_EUC  = ["         本田", "         大黒", "         津崎", "         山本"]                                    # 4人
M1_MIKI = ["         髙谷", "         富岡", "         冨田", "         那須", "         田村",
           "         嶋川", "         山下"]                                                                      # 7人
M2_EUC  = ["        M2山下", "         堂面", "         森村", "         梅田", "         加藤", "         親泊"] # 6人
M2_MIKI = ["         外村", "         三輪", "         三好", "         提中", "         中原", "         穐西"]  # 6人

print_result = false
error = false

target = []
if ARGV[0] == "-h" || ARGV[0] == "--help" then
  puts
  puts "引数1 ： 対象メンバー"
  puts "         → all，miki，euc，u4(_miki，_euc)，m1(_miki，_euc)，m2(_miki，_euc)"
  puts "引数2 ： 選出人数"
  puts "         → 全員         - #{U4_EUC.size + U4_MIKI.size + M1_EUC.size + M1_MIKI.size + M2_EUC.size + M2_MIKI.size}人"
  puts "         → U4           - #{U4_EUC.size + U4_MIKI.size}人"
  puts "         → M1           - #{M1_EUC.size + M1_MIKI.size}人"
  puts "         → M2           - #{M2_EUC.size + M2_MIKI.size}人"
  puts "         → 三木班       - #{U4_MIKI.size + M1_MIKI.size + M2_MIKI.size}人"
  puts "         → EUC班        - #{U4_EUC.size + M1_EUC.size + M2_EUC.size}人"
  puts "         → 三木班（U4） - #{U4_MIKI.size}人"
  puts "         → 三木班（M1） - #{M1_MIKI.size}人"
  puts "         → 三木班（M2） - #{M2_MIKI.size}人"
  puts "         → EUC班（U4）  - #{U4_EUC.size}人"
  puts "         → EUC班（M1）  - #{M1_EUC.size}人"
  puts "         → EUC班（M2）  - #{M2_EUC.size}人"
elsif ARGV.size == 2 then
  print_result = true
  if ARGV[0] == "all" then
    error = true if ARGV[1].to_i > (U4_EUC.size + U4_MIKI.size + M1_EUC.size + M1_MIKI.size + M2_EUC.size + M2_MIKI.size)
    target << U4_MIKI
    target << U4_EUC
    target << M1_MIKI
    target << M1_EUC
    target << M2_MIKI
    target << M2_EUC
  elsif ARGV[0] == "miki" then
    error = true if ARGV[1].to_i > (U4_MIKI.size + M1_MIKI.size + M2_MIKI.size)
    target << U4_MIKI
    target << M1_MIKI
    target << M2_MIKI
  elsif ARGV[0] == "euc" then
    error = true if ARGV[1].to_i > (U4_EUC.size + M1_EUC.size + M2_EUC.size)
    target << U4_EUC
    target << M1_EUC
    target << M2_EUC
  elsif ARGV[0] == "u4" then
    error = true if ARGV[1].to_i > (U4_EUC.size + U4_MIKI.size)
    target << U4_MIKI
    target << U4_EUC
  elsif ARGV[0] == "u4_miki" then
    error = true if ARGV[1].to_i > (U4_MIKI.size)
    target << U4_MIKI
  elsif ARGV[0] == "u4_euc" then
    error = true if ARGV[1].to_i > (U4_EUC.size)
    target << U4_EUC
  elsif ARGV[0] == "m1" then
    error = true if ARGV[1].to_i > (M1_EUC.size + M1_MIKI.size)
    target << M1_MIKI
    target << M1_EUC
  elsif ARGV[0] == "m1_miki" then
    error = true if ARGV[1].to_i > (M1_MIKI.size)
    target << M1_MIKI
  elsif ARGV[0] == "m1_euc" then
    error = true if ARGV[1].to_i > (M1_EUC.size)
    target << M1_EUC
  elsif ARGV[0] == "m2" then
    error = true if ARGV[1].to_i > (M2_EUC.size + M2_MIKI.size)
    target << M2_MIKI
    target << M2_EUC
  elsif ARGV[0] == "m2_miki" then
    error = true if ARGV[1].to_i > (M2_MIKI.size)
    target << M2_MIKI
  elsif ARGV[0] == "m2_euc" then
    error = true if ARGV[1].to_i > (M2_EUC.size)
    target << M2_EUC
  end
else
  puts
  puts "引数が間違っています．"
  puts "-h，--help ： ヘルプ表示"
end
target.flatten!
target.shuffle!
if print_result then
  if !error then
    puts
    puts "-*-*-*-選出結果-*-*-*-"
    puts target.sample(ARGV[1].to_i)
    puts "-*-*-*--*-*-*--*-*-*-*"
  else
    puts "選出人数が多すぎます．"
  end
end
