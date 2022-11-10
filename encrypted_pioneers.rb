FINAL_HASH = {}

lower_case_letters = ('a'..'z').to_a
counter = 1
lower_case_letters.each do |let|
  FINAL_HASH[let] = counter
  counter += 1
end

def rot_13_decipher(letters)
  final_word = ""
  letters.chars.each do |let|
    if FINAL_HASH.include?(let)
      counter = 1
      value = FINAL_HASH[let]
      loop do
        value += 1
        value = 1 if value == 27
        counter += 1
        break if counter >= 14
      end
      final_word << FINAL_HASH.key(value)
    elsif FINAL_HASH.include?(let.downcase)
      counter = 1
      value = FINAL_HASH[let.downcase]
      loop do
        value += 1
        value = 1 if value == 27
        counter += 1
        break if counter >= 14
      end
      final_word << FINAL_HASH.key(value).upcase
    else
      final_word << let
    end
  end
  final_word
end

ENCRYPTED_PIONEERS = [
  'Nqn Ybirynpr',
  'Tenpr Ubccre',
  'Nqryr Tbyqfgvar',
  'Nyna Ghevat',
  'Puneyrf Onoontr',
  'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
  'Wbua Ngnanfbss',
  'Ybvf Unvog',
  'Pynhqr Funaaba',
  'Fgrir Wbof',
  'Ovyy Tngrf',
  'Gvz Orearef-Yrr',
  'Fgrir Jbmavnx',
  'Xbaenq Mhfr',
  'Fve Nagbal Ubner',
  'Zneiva Zvafxl',
  'Lhxvuveb Zngfhzbgb',
  'Unllvz Fybavzfxv',
  'Tregehqr Oynapu'
]

ENCRYPTED_PIONEERS.each do |name|
  puts rot_13_decipher(name)
end
