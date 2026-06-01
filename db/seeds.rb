# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"

kanas = [
  # Hiragana
  { character: "あ", romaji: "a", kind: "hiragana" },
  { character: "い", romaji: "i", kind: "hiragana" },
  { character: "う", romaji: "u", kind: "hiragana" },
  { character: "え", romaji: "e", kind: "hiragana" },
  { character: "お", romaji: "o", kind: "hiragana" },

  { character: "か", romaji: "ka", kind: "hiragana" },
  { character: "き", romaji: "ki", kind: "hiragana" },
  { character: "く", romaji: "ku", kind: "hiragana" },
  { character: "け", romaji: "ke", kind: "hiragana" },
  { character: "こ", romaji: "ko", kind: "hiragana" },

  { character: "さ", romaji: "sa", kind: "hiragana" },
  { character: "し", romaji: "shi", kind: "hiragana" },
  { character: "す", romaji: "su", kind: "hiragana" },
  { character: "せ", romaji: "se", kind: "hiragana" },
  { character: "そ", romaji: "so", kind: "hiragana" },

  { character: "た", romaji: "ta", kind: "hiragana" },
  { character: "ち", romaji: "chi", kind: "hiragana" },
  { character: "つ", romaji: "tsu", kind: "hiragana" },
  { character: "て", romaji: "te", kind: "hiragana" },
  { character: "と", romaji: "to", kind: "hiragana" },

  { character: "な", romaji: "na", kind: "hiragana" },
  { character: "に", romaji: "ni", kind: "hiragana" },
  { character: "ぬ", romaji: "nu", kind: "hiragana" },
  { character: "ね", romaji: "ne", kind: "hiragana" },
  { character: "の", romaji: "no", kind: "hiragana" },

  { character: "は", romaji: "ha", kind: "hiragana" },
  { character: "ひ", romaji: "hi", kind: "hiragana" },
  { character: "ふ", romaji: "fu", kind: "hiragana" },
  { character: "へ", romaji: "he", kind: "hiragana" },
  { character: "ほ", romaji: "ho", kind: "hiragana" },

  { character: "ま", romaji: "ma", kind: "hiragana" },
  { character: "み", romaji: "mi", kind: "hiragana" },
  { character: "む", romaji: "mu", kind: "hiragana" },
  { character: "め", romaji: "me", kind: "hiragana" },
  { character: "も", romaji: "mo", kind: "hiragana" },

  { character: "や", romaji: "ya", kind: "hiragana" },
  { character: "ゆ", romaji: "yu", kind: "hiragana" },
  { character: "よ", romaji: "yo", kind: "hiragana" },

  { character: "ら", romaji: "ra", kind: "hiragana" },
  { character: "り", romaji: "ri", kind: "hiragana" },
  { character: "る", romaji: "ru", kind: "hiragana" },
  { character: "れ", romaji: "re", kind: "hiragana" },
  { character: "ろ", romaji: "ro", kind: "hiragana" },

  { character: "わ", romaji: "wa", kind: "hiragana" },
  { character: "を", romaji: "wo", kind: "hiragana" },
  { character: "ん", romaji: "n", kind: "hiragana" },

  # Katakana
  { character: "ア", romaji: "a", kind: "katakana" },
  { character: "イ", romaji: "i", kind: "katakana" },
  { character: "ウ", romaji: "u", kind: "katakana" },
  { character: "エ", romaji: "e", kind: "katakana" },
  { character: "オ", romaji: "o", kind: "katakana" },

  { character: "カ", romaji: "ka", kind: "katakana" },
  { character: "キ", romaji: "ki", kind: "katakana" },
  { character: "ク", romaji: "ku", kind: "katakana" },
  { character: "ケ", romaji: "ke", kind: "katakana" },
  { character: "コ", romaji: "ko", kind: "katakana" },

  { character: "サ", romaji: "sa", kind: "katakana" },
  { character: "シ", romaji: "shi", kind: "katakana" },
  { character: "ス", romaji: "su", kind: "katakana" },
  { character: "セ", romaji: "se", kind: "katakana" },
  { character: "ソ", romaji: "so", kind: "katakana" },

  { character: "タ", romaji: "ta", kind: "katakana" },
  { character: "チ", romaji: "chi", kind: "katakana" },
  { character: "ツ", romaji: "tsu", kind: "katakana" },
  { character: "テ", romaji: "te", kind: "katakana" },
  { character: "ト", romaji: "to", kind: "katakana" },

  { character: "ナ", romaji: "na", kind: "katakana" },
  { character: "ニ", romaji: "ni", kind: "katakana" },
  { character: "ヌ", romaji: "nu", kind: "katakana" },
  { character: "ネ", romaji: "ne", kind: "katakana" },
  { character: "ノ", romaji: "no", kind: "katakana" },

  { character: "ハ", romaji: "ha", kind: "katakana" },
  { character: "ヒ", romaji: "hi", kind: "katakana" },
  { character: "フ", romaji: "fu", kind: "katakana" },
  { character: "ヘ", romaji: "he", kind: "katakana" },
  { character: "ホ", romaji: "ho", kind: "katakana" },

  { character: "マ", romaji: "ma", kind: "katakana" },
  { character: "ミ", romaji: "mi", kind: "katakana" },
  { character: "ム", romaji: "mu", kind: "katakana" },
  { character: "メ", romaji: "me", kind: "katakana" },
  { character: "モ", romaji: "mo", kind: "katakana" },

  { character: "ヤ", romaji: "ya", kind: "katakana" },
  { character: "ユ", romaji: "yu", kind: "katakana" },
  { character: "ヨ", romaji: "yo", kind: "katakana" },

  { character: "ラ", romaji: "ra", kind: "katakana" },
  { character: "リ", romaji: "ri", kind: "katakana" },
  { character: "ル", romaji: "ru", kind: "katakana" },
  { character: "レ", romaji: "re", kind: "katakana" },
  { character: "ロ", romaji: "ro", kind: "katakana" },

  { character: "ワ", romaji: "wa", kind: "katakana" },
  { character: "ヲ", romaji: "wo", kind: "katakana" },
  { character: "ン", romaji: "n", kind: "katakana" }
]

kanas.each do |kana|
  Kana.find_or_create_by!(character: kana[:character]) do |k|
    k.romaji = kana[:romaji]
    k.kind = kana[:kind]
  end
end

puts "Seeded #{Kana.count} kanas 🌸"

# Tạo 25 bài học Minna no Nihongo
lessons = {}
(1..25).each do |n|
  lessons[n] = Lesson.find_or_create_by!(number: n) do |l|
    l.name = "Bài #{n}"
  end
end

puts "Seeded 25 lessons 📚"

all_vocabs = [
  # Bài 1: Chào hỏi & Giới thiệu
  { lesson: 1, word: "わたし", kana: "わたし", meaning: "tôi", romaji: "watashi" },
  { lesson: 1, word: "わたしたち", kana: "わたしたち", meaning: "chúng tôi", romaji: "watashitachi" },
  { lesson: 1, word: "あなた", kana: "あなた", meaning: "bạn", romaji: "anata" },
  { lesson: 1, word: "あのひと", kana: "あのひと", meaning: "người kia", romaji: "ano hito" },
  { lesson: 1, word: "あのかた", kana: "あのかた", meaning: "người kia (lịch sự)", romaji: "ano kata" },
  { lesson: 1, word: "みなさん", kana: "みなさん", meaning: "mọi người", romaji: "minasan" },
  { lesson: 1, word: "～さん", kana: "～さん", meaning: "anh/chị (dùng sau tên)", romaji: "~san" },
  { lesson: 1, word: "～ちゃん", kana: "～ちゃん", meaning: "cháu (dùng với trẻ em)", romaji: "~chan" },
  { lesson: 1, word: "～くん", kana: "～くん", meaning: "cậu (dùng với con trai)", romaji: "~kun" },
  { lesson: 1, word: "～じん", kana: "～じん", meaning: "người (quốc tịch)", romaji: "~jin" },
  { lesson: 1, word: "せんせい", kana: "せんせい", meaning: "giáo viên", romaji: "sensei" },
  { lesson: 1, word: "きょうし", kana: "きょうし", meaning: "giáo viên (nghề nghiệp)", romaji: "kyoushi" },
  { lesson: 1, word: "がくせい", kana: "がくせい", meaning: "sinh viên", romaji: "gakusei" },
  { lesson: 1, word: "かいしゃいん", kana: "かいしゃいん", meaning: "nhân viên công ty", romaji: "kaishain" },
  { lesson: 1, word: "はい", kana: "はい", meaning: "vâng", romaji: "hai" },
  { lesson: 1, word: "いいえ", kana: "いいえ", meaning: "không", romaji: "iie" },
  { lesson: 1, word: "はじめまして", kana: "はじめまして", meaning: "rất vui được gặp", romaji: "hajimemashite" },
  { lesson: 1, word: "どうぞよろしく", kana: "どうぞよろしく", meaning: "xin hãy giúp đỡ", romaji: "douzo yoroshiku" },

  # Bài 2: Đồ vật & Chỉ định
  { lesson: 2, word: "これ", kana: "これ", meaning: "cái này", romaji: "kore" },
  { lesson: 2, word: "それ", kana: "それ", meaning: "cái đó", romaji: "sore" },
  { lesson: 2, word: "あれ", kana: "あれ", meaning: "cái kia", romaji: "are" },
  { lesson: 2, word: "この", kana: "この", meaning: "cái này ( + danh từ)", romaji: "kono" },
  { lesson: 2, word: "その", kana: "その", meaning: "cái đó (+ danh từ)", romaji: "sono" },
  { lesson: 2, word: "あの", kana: "あの", meaning: "cái kia (+ danh từ)", romaji: "ano" },
  { lesson: 2, word: "ほん", kana: "ほん", meaning: "sách", romaji: "hon" },
  { lesson: 2, word: "じしょ", kana: "じしょ", meaning: "từ điển", romaji: "jisho" },
  { lesson: 2, word: "ざっし", kana: "ざっし", meaning: "tạp chí", romaji: "zasshi" },
  { lesson: 2, word: "しんぶん", kana: "しんぶん", meaning: "báo", romaji: "shinbun" },
  { lesson: 2, word: "かばん", kana: "かばん", meaning: "cặp, túi xách", romaji: "kaban" },
  { lesson: 2, word: "えんぴつ", kana: "えんぴつ", meaning: "bút chì", romaji: "enpitsu" },
  { lesson: 2, word: "ノート", kana: "ノート", meaning: "vở", romaji: "nooto" },

  # Bài 3: Địa điểm & Đây/Đó
  { lesson: 3, word: "ここ", kana: "ここ", meaning: "đây", romaji: "koko" },
  { lesson: 3, word: "そこ", kana: "そこ", meaning: "đó", romaji: "soko" },
  { lesson: 3, word: "あそこ", kana: "あそこ", meaning: "kia", romaji: "asoko" },
  { lesson: 3, word: "こちら", kana: "こちら", meaning: "đây (lịch sự)", romaji: "kochira" },
  { lesson: 3, word: "じむしょ", kana: "じむしょ", meaning: "văn phòng", romaji: "jimusho" },
  { lesson: 3, word: "としょかん", kana: "としょかん", meaning: "thư viện", romaji: "toshokan" },
  { lesson: 3, word: "がっこう", kana: "がっこう", meaning: "trường học", romaji: "gakkou" },
  { lesson: 3, word: "デパート", kana: "デパート", meaning: "siêu thị bách hóa", romaji: "depaato" },
  { lesson: 3, word: "いえ", kana: "いえ", meaning: "nhà", romaji: "ie" },
  { lesson: 3, word: "うち", kana: "うち", meaning: "nhà (của tôi)", romaji: "uchi" },

  # Bài 4: Thời gian & Hoạt động hàng ngày
  { lesson: 4, word: "おきます", kana: "おきます", meaning: "thức dậy", romaji: "okimasu" },
  { lesson: 4, word: "ねます", kana: "ねます", meaning: "ngủ", romaji: "nemasu" },
  { lesson: 4, word: "はたらきます", kana: "はたらきます", meaning: "làm việc", romaji: "hatarakimasu" },
  { lesson: 4, word: "やすみます", kana: "やすみます", meaning: "nghỉ ngơi", romaji: "yasumimasu" },
  { lesson: 4, word: "ぎんこう", kana: "ぎんこう", meaning: "ngân hàng", romaji: "ginkou" },
  { lesson: 4, word: "ゆうびんきょく", kana: "ゆうびんきょく", meaning: "bưu điện", romaji: "yuubinkyoku" },
  { lesson: 4, word: "いま", kana: "いま", meaning: "bây giờ", romaji: "ima" },
  { lesson: 4, word: "なんじ", kana: "なんじ", meaning: "mấy giờ", romaji: "nanji" },
  { lesson: 4, word: "あさ", kana: "あさ", meaning: "buổi sáng", romaji: "asa" },
  { lesson: 4, word: "ひる", kana: "ひる", meaning: "buổi trưa", romaji: "hiru" },
  { lesson: 4, word: "ばん", kana: "ばん", meaning: "buổi tối", romaji: "ban" },

  # Bài 5: Di chuyển & Phương tiện
  { lesson: 5, word: "いきます", kana: "いきます", meaning: "đi", romaji: "ikimasu" },
  { lesson: 5, word: "かえります", kana: "かえります", meaning: "về", romaji: "kaerimasu" },
  { lesson: 5, word: "きます", kana: "きます", meaning: "đến", romaji: "kimasu" },
  { lesson: 5, word: "でんしゃ", kana: "でんしゃ", meaning: "tàu điện", romaji: "densha" },
  { lesson: 5, word: "バス", kana: "バス", meaning: "xe buýt", romaji: "basu" },
  { lesson: 5, word: "じてんしゃ", kana: "じてんしゃ", meaning: "xe đạp", romaji: "jitensha" },
  { lesson: 5, word: "タクシー", kana: "タクシー", meaning: "taxi", romaji: "takushii" },
  { lesson: 5, word: "あるきます", kana: "あるきます", meaning: "đi bộ", romaji: "arukimasu" },

  # Bài 6: Ăn uống
  { lesson: 6, word: "たべます", kana: "たべます", meaning: "ăn", romaji: "tabemasu" },
  { lesson: 6, word: "のみます", kana: "のみます", meaning: "uống", romaji: "nomimasu" },
  { lesson: 6, word: "ごはん", kana: "ごはん", meaning: "cơm", romaji: "gohan" },
  { lesson: 6, word: "パン", kana: "パン", meaning: "bánh mì", romaji: "pan" },
  { lesson: 6, word: "みず", kana: "みず", meaning: "nước", romaji: "mizu" },
  { lesson: 6, word: "おちゃ", kana: "おちゃ", meaning: "trà xanh", romaji: "ocha" },
  { lesson: 6, word: "こうちゃ", kana: "こうちゃ", meaning: "trà đen", romaji: "koucha" },
  { lesson: 6, word: "おさけ", kana: "おさけ", meaning: "rượu sake", romaji: "osake" },

  # Bài 7: Công cụ & Hành động
  { lesson: 7, word: "かきます", kana: "かきます", meaning: "viết, vẽ", romaji: "kakimasu" },
  { lesson: 7, word: "よみます", kana: "よみます", meaning: "đọc", romaji: "yomimasu" },
  { lesson: 7, word: "ききます", kana: "ききます", meaning: "nghe", romaji: "kikimasu" },
  { lesson: 7, word: "みます", kana: "みます", meaning: "xem", romaji: "mimasu" },
  { lesson: 7, word: "はし", kana: "はし", meaning: "đũa", romaji: "hashi" },
  { lesson: 7, word: "ナイフ", kana: "ナイフ", meaning: "dao", romaji: "naifu" },
  { lesson: 7, word: "フォーク", kana: "フォーク", meaning: "nĩa", romaji: "fooku" },

  # Bài 8: Tính từ đuôi i & đuôi na (Đầy đủ)
  { lesson: 8, word: "ハンサム", kana: "ハンサム", meaning: "đẹp trai (na)", romaji: "hansamu" },
  { lesson: 8, word: "きれい", kana: "きれい", meaning: "đẹp, sạch sẽ (na)", romaji: "kirei" },
  { lesson: 8, word: "しずか", kana: "しずか", meaning: "yên tĩnh (na)", romaji: "shizuka" },
  { lesson: 8, word: "にぎやか", kana: "にぎやか", meaning: "náo nhiệt (na)", romaji: "nigiyaka" },
  { lesson: 8, word: "ゆうめい", kana: "ゆうめい", meaning: "nổi tiếng (na)", romaji: "yuumei" },
  { lesson: 8, word: "しんせつ", kana: "しんせつ", meaning: "tốt bụng (na)", romaji: "shinsetsu" },
  { lesson: 8, word: "げんき", kana: "げんき", meaning: "khỏe mạnh (na)", romaji: "genki" },
  { lesson: 8, word: "ひま", kana: "ひま", meaning: "rảnh rỗi (na)", romaji: "hima" },
  { lesson: 8, word: "べんり", kana: "べんり", meaning: "tiện lợi (na)", romaji: "benri" },
  { lesson: 8, word: "すてき", kana: "すてき", meaning: "tuyệt vời (na)", romaji: "suteki" },
  { lesson: 8, word: "おおきい", kana: "おおきい", meaning: "lớn, to", romaji: "ookii" },
  { lesson: 8, word: "ちいさい", kana: "ちいさい", meaning: "nhỏ, bé", romaji: "chiisai" },
  { lesson: 8, word: "あたらしい", kana: "あたらしい", meaning: "mới", romaji: "atarashii" },
  { lesson: 8, word: "ふるい", kana: "ふるい", meaning: "cũ", romaji: "furui" },
  { lesson: 8, word: "いい", kana: "いい", meaning: "tốt", romaji: "ii" },
  { lesson: 8, word: "わるい", kana: "わるい", meaning: "xấu, tồi", romaji: "warui" },
  { lesson: 8, word: "あつい", kana: "あつい", meaning: "nóng", romaji: "atsui" },
  { lesson: 8, word: "さむい", kana: "さむい", meaning: "lạnh (thời tiết)", romaji: "samui" },
  { lesson: 8, word: "つめたい", kana: "つめたい", meaning: "lạnh (cảm giác)", romaji: "tsumetai" },
  { lesson: 8, word: "むずかしい", kana: "むずかしい", meaning: "khó", romaji: "muzukashii" },
  { lesson: 8, word: "やさしい", kana: "やさしい", meaning: "dễ", romaji: "yasashii" },
  { lesson: 8, word: "たかい", kana: "たかい", meaning: "cao, đắt", romaji: "takai" },
  { lesson: 8, word: "安い", kana: "やすい", meaning: "rẻ", romaji: "yasui" },
  { lesson: 8, word: "ひくい", kana: "ひくい", meaning: "thấp", romaji: "hikui" },
  { lesson: 8, word: "おもしろい", kana: "おもしろい", meaning: "thú vị", romaji: "omoshiroi" },
  { lesson: 8, word: "おいしい", kana: "おいしい", meaning: "ngon", romaji: "oishii" },
  { lesson: 8, word: "いそ가しい", kana: "いそがしい", meaning: "bận rộn", romaji: "isogashii" },
  { lesson: 8, word: "たのしい", kana: "たのしい", meaning: "vui vẻ", romaji: "tanoshii" },
  { lesson: 8, word: "しろい", kana: "しろい", meaning: "trắng", romaji: "shiroi" },
  { lesson: 8, word: "くろい", kana: "くろい", meaning: "đen", romaji: "kuroi" },
  { lesson: 8, word: "あかい", kana: "あかい", meaning: "đỏ", romaji: "akai" },
  { lesson: 8, word: "あおい", kana: "あおい", meaning: "xanh da trời", romaji: "aoi" },
  { lesson: 8, word: "さくら", kana: "さくら", meaning: "hoa anh đào", romaji: "sakura" },
  { lesson: 8, word: "やま", kana: "やま", meaning: "núi", romaji: "yama" },
  { lesson: 8, word: "まち", kana: "まち", meaning: "thành phố, thị trấn", romaji: "machi" },
  { lesson: 8, word: "たべもの", kana: "たべもの", meaning: "đồ ăn", romaji: "tabemono" },
  { lesson: 8, word: "くるま", kana: "くるま", meaning: "xe hơi", romaji: "kuruma" },
  { lesson: 8, word: "ところ", kana: "ところ", meaning: "nơi, chỗ", romaji: "tokoro" },
  { lesson: 8, word: "りょう", kana: "りょう", meaning: "ký túc xá", romaji: "ryou" },
  { lesson: 8, word: "べんきょう", kana: "べんきょう", meaning: "việc học", romaji: "benkyou" },
  { lesson: 8, word: "せいかつ", kana: "せいかつ", meaning: "cuộc sống", romaji: "seikatsu" },
  { lesson: 8, word: "しごと", kana: "しごと", meaning: "công việc", romaji: "shigoto" },
  { lesson: 8, word: "どう", kana: "どう", meaning: "thế nào", romaji: "dou" },
  { lesson: 8, word: "どんな", kana: "どんな", meaning: "như thế nào", romaji: "donna" },
  { lesson: 8, word: "とても", kana: "とても", meaning: "rất", romaji: "totemo" },
  { lesson: 8, word: "あまり", kana: "あまり", meaning: "không... lắm", romaji: "amari" },
  { lesson: 8, word: "そして", kana: "そして", meaning: "và, thêm nữa", romaji: "soshite" },
  { lesson: 8, word: "が", kana: "が", meaning: "nhưng", romaji: "ga" },

  # Bài 9: Sở thích & Khả năng
  { lesson: 9, word: "わかります", kana: "わかります", meaning: "hiểu, biết", romaji: "wakarimasu" },
  { lesson: 9, word: "できます", kana: "できます", meaning: "có thể làm được", romaji: "dekimasu" },
  { lesson: 9, word: "すき", kana: "すき", meaning: "thích (na)", romaji: "suki" },
  { lesson: 9, word: "きらい", kana: "きらい", meaning: "ghét (na)", romaji: "kirai" },
  { lesson: 9, word: "じょうず", kana: "じょうず", meaning: "giỏi (na)", romaji: "jouzu" },
  { lesson: 9, word: "へた", kana: "へた", meaning: "kém (na)", romaji: "heta" },

  # Bài 10: Tồn tại (あります / います)
  { lesson: 10, word: "あります", kana: "あります", meaning: "có (vật)", romaji: "arimasu" },
  { lesson: 10, word: "います", kana: "います", meaning: "có (người, động vật)", romaji: "imasu" },
  { lesson: 10, word: "いす", kana: "いす", meaning: "ghế", romaji: "isu" },
  { lesson: 10, word: "テーブル", kana: "テーブル", meaning: "bàn", romaji: "teeburu" },
  { lesson: 10, word: "ねこ", kana: "ねこ", meaning: "mèo", romaji: "neko" },
  { lesson: 10, word: "いぬ", kana: "いぬ", meaning: "chó", romaji: "inu" },

    # Bài 11: Số lượng & Gia đình
  { lesson: 11, word: "ひとつ", kana: "ひとつ", meaning: "1 cái", romaji: "hitotsu" },
  { lesson: 11, word: "ふたつ", kana: "ふたつ", meaning: "2 cái", romaji: "futatsu" },
  { lesson: 11, word: "みっつ", kana: "みっつ", meaning: "3 cái", romaji: "mittsu" },
  { lesson: 11, word: "よっつ", kana: "よっつ", meaning: "4 cái", romaji: "yottsu" },
  { lesson: 11, word: "いつつ", kana: "いつつ", meaning: "5 cái", romaji: "itsutsu" },
  { lesson: 11, word: "かぞく", kana: "かぞく", meaning: "gia đình", romaji: "kazoku" },
  { lesson: 11, word: "きょうだい", kana: "きょうだい", meaning: "anh chị em", romaji: "kyoudai" },
  { lesson: 11, word: "ちち", kana: "ちち", meaning: "bố (của tôi)", romaji: "chichi" },
  { lesson: 11, word: "はは", kana: "はは", meaning: "mẹ (của tôi)", romaji: "haha" },
  { lesson: 11, word: "おとうさん", kana: "おとうさん", meaning: "bố (của người khác)", romaji: "otousan" },
  { lesson: 11, word: "おかあさん", kana: "おかあさん", meaning: "mẹ (của người khác)", romaji: "okaasan" },

  # Bài 12: Quá khứ & So sánh
  { lesson: 12, word: "あめ", kana: "あめ", meaning: "mưa", romaji: "ame" },
  { lesson: 12, word: "ゆき", kana: "ゆき", meaning: "tuyết", romaji: "yuki" },
  { lesson: 12, word: "たのしい", kana: "たのしい", meaning: "vui vẻ", romaji: "tanoshii" },
  { lesson: 12, word: "さむい", kana: "さむい", meaning: "lạnh", romaji: "samui" },
  { lesson: 12, word: "あつい", kana: "あつい", meaning: "nóng", romaji: "atsui" },
  { lesson: 12, word: "かんたん", kana: "かんたん", meaning: "đơn giản (na)", romaji: "kantan" },
  { lesson: 12, word: "むずかしい", kana: "むずかしい", meaning: "khó", romaji: "muzukashii" },
  { lesson: 12, word: "やすかった", kana: "やすかった", meaning: "đã rẻ / đã dễ", romaji: "yasukatta" },

  # Bài 13: Mong muốn
  { lesson: 13, word: "ほしい", kana: "ほしい", meaning: "muốn có", romaji: "hoshii" },
  { lesson: 13, word: "あそびます", kana: "あそびます", meaning: "chơi, đi chơi", romaji: "asobimasu" },
  { lesson: 13, word: "かいます", kana: "かいます", meaning: "mua", romaji: "kaimasu" },
  { lesson: 13, word: "いきたい", kana: "いきたい", meaning: "muốn đi", romaji: "ikitai" },
  { lesson: 13, word: "みたがっています", kana: "みたがっています", meaning: "muốn xem (người thứ 3)", romaji: "mitagatteimasu" },

  # Bài 14: Thể Te-form (Yêu cầu, kết nối)
  { lesson: 14, word: "まちます", kana: "まちます", meaning: "đợi", romaji: "machimasu" },
  { lesson: 14, word: "あけます", kana: "あけます", meaning: "mở", romaji: "akemasu" },
  { lesson: 14, word: "しめます", kana: "しめます", meaning: "đóng", romaji: "shimemasu" },
  { lesson: 14, word: "てつだいます", kana: "てつだいます", meaning: "giúp đỡ", romaji: "tetsudaimasu" },
  { lesson: 14, word: "みせます", kana: "みせます", meaning: "cho xem", romaji: "misemasu" },

  # Bài 15: Cho phép & Trạng thái
  { lesson: 15, word: "すわります", kana: "すわります", meaning: "ngồi", romaji: "suwarimasu" },
  { lesson: 15, word: "たちます", kana: "たちます", meaning: "đứng", romaji: "tachimasu" },
  { lesson: 15, word: "しっています", kana: "しっています", meaning: "biết (trạng thái)", romaji: "shitteimasu" },
  { lesson: 15, word: "しりません", kana: "しりません", meaning: "không biết", romaji: "shirimasen" },
  { lesson: 15, word: "やすみます", kana: "やすみます", meaning: "nghỉ", romaji: "yasumimasu" },

  # Bài 16: Kết hợp hành động (Te-form)
  { lesson: 16, word: "のりかえます", kana: "のりかえます", meaning: "chuyển xe/tàu", romaji: "norikaemasu" },
  { lesson: 16, word: "わかい", kana: "わかい", meaning: "trẻ", romaji: "wakai" },
  { lesson: 16, word: "べんきょうします", kana: "べんきょうします", meaning: "học", romaji: "benkyou shimasu" },
  { lesson: 16, word: "およぎます", kana: "およぎます", meaning: "bơi", romaji: "oyogimasu" },

  # Bài 17: Thể Nai (Cấm đoán)
  { lesson: 17, word: "わすれます", kana: "わすれます", meaning: "quên", romaji: "wasuremasu" },
  { lesson: 17, word: "くすり", kana: "くすり", meaning: "thuốc", romaji: "kusuri" },
  { lesson: 17, word: "のりません", kana: "のりません", meaning: "không đi (xe/tàu)", romaji: "norimasen" },
  { lesson: 17, word: "はいってはいけません", kana: "はいってはいけません", meaning: "không được vào", romaji: "haitte wa ikemasen" },

  # Bài 18: Thể từ điển & Khả năng
  { lesson: 18, word: "できます", kana: "できます", meaning: "có thể làm được", romaji: "dekimasu" },
  { lesson: 18, word: "しゅみ", kana: "しゅみ", meaning: "sở thích", romaji: "shumi" },
  { lesson: 18, word: "うたいます", kana: "うたいます", meaning: "hát", romaji: "utaimasu" },
  { lesson: 18, word: "およぐ", kana: "およぐ", meaning: "bơi (từ điển)", romaji: "oyogu" },

  # Bài 19: Thể Ta (Kinh nghiệm)
  { lesson: 19, word: "のぼります", kana: "のぼります", meaning: "leo", romaji: "noborimasu" },
  { lesson: 19, word: "富士山", kana: "ふじさん", meaning: "núi Phú Sĩ", romaji: "fujisan" },
  { lesson: 19, word: "だんだん", kana: "だんだん", meaning: "dần dần", romaji: "dandan" },
  { lesson: 19, word: "行ったことがあります", kana: "いったことがあります", meaning: "đã từng đi", romaji: "itta koto ga arimasu" },

  # Bài 20: Thể thông thường (Plain form)
  { lesson: 20, word: "ことば", kana: "ことば", meaning: "từ, ngôn ngữ", romaji: "kotoba" },
  { lesson: 20, word: "ぶっか", kana: "ぶっか", meaning: "giá cả", romaji: "bukka" },
  { lesson: 20, word: "たかいです", kana: "たかいです", meaning: "đắt (lịch sự)", romaji: "takai desu" },
  { lesson: 20, word: "たかい", kana: "たかい", meaning: "đắt (thông thường)", romaji: "takai" },

  # Bài 21: Ý kiến & Dự đoán
  { lesson: 21, word: "おもいます", kana: "おもいます", meaning: "nghĩ rằng", romaji: "omoimasu" },
  { lesson: 21, word: "にゅうす", kana: "にゅうす", meaning: "tin tức", romaji: "nyuusu" },
  { lesson: 21, word: "あした", kana: "あした", meaning: "ngày mai", romaji: "ashita" },
  { lesson: 21, word: "たぶん", kana: "たぶん", meaning: "có lẽ", romaji: "tabun" },
  { lesson: 21, word: "あめがふるでしょう", kana: "あめがふるでしょう", meaning: "có lẽ trời sẽ mưa", romaji: "ame ga furu deshou" },

  # Bài 22: Định ngữ (Câu mô tả)
  { lesson: 22, word: "きます", kana: "きます", meaning: "mặc (quần áo)", romaji: "kimasu" },
  { lesson: 22, word: "ぼうし", kana: "ぼうし", meaning: "mũ", romaji: "boushi" },
  { lesson: 22, word: "あたらしい", kana: "あたらしい", meaning: "mới", romaji: "atarashii" },
  { lesson: 22, word: "ふるい", kana: "ふるい", meaning: "cũ", romaji: "furui" },
  { lesson: 22, word: "きれいな", kana: "きれいな", meaning: "đẹp, sạch sẽ (na)", romaji: "kirei na" },

  # Bài 23: Khi nào / Hệ quả
  { lesson: 23, word: "みち", kana: "みち", meaning: "đường", romaji: "michi" },
  { lesson: 23, word: "ひきます", kana: "ひきます", meaning: "kéo, chơi đàn", romaji: "hikimasu" },
  { lesson: 23, word: "ピアノ", kana: "ピアノ", meaning: "piano", romaji: "piano" },
  { lesson: 23, word: "あぶない", kana: "あぶない", meaning: "nguy hiểm", romaji: "abunai" },

  # Bài 24: Cho và nhận
  { lesson: 24, word: "くれます", kana: "くれます", meaning: "cho (tôi)", romaji: "kuremasu" },
  { lesson: 24, word: "あげます", kana: "あげます", meaning: "cho (người khác)", romaji: "agemasu" },
  { lesson: 24, word: "つれていきます", kana: "つれていきます", meaning: "dẫn đi", romaji: "tsureteikimasu" },
  { lesson: 24, word: "もらいます", kana: "もらいます", meaning: "nhận được", romaji: "moraimasu" },

  # Bài 25: Giả định (もし)
  { lesson: 25, word: "かんがえます", kana: "かんがえます", meaning: "suy nghĩ", romaji: "kangaemasu" },
  { lesson: 25, word: "もし", kana: "もし", meaning: "nếu", romaji: "moshi" },
  { lesson: 25, word: "あめがふったら", kana: "あめがふったら", meaning: "nếu trời mưa", romaji: "ame ga futtara" },
  { lesson: 25, word: "よかったら", kana: "よかったら", meaning: "nếu được thì / nếu tiện", romaji: "yokattara" },
  { lesson: 25, word: "たいしかん", kana: "たいしかん", meaning: "đại sứ quán", romaji: "taishikan" },
  { lesson: 25, word: "りゅうがくします", kana: "りゅうがくします", meaning: "du học", romaji: "ryuugaku shimasu" }
]


all_vocabs.each do |v|
  begin
    voc = Vocabulary.find_or_initialize_by(word: v[:word], lesson: lessons[v[:lesson]])
    voc.update!(
      kana: v[:kana],
      meaning: v[:meaning],
      romaji: v[:romaji],
      word: v[:word]
    )

    # Tải và đính kèm audio từ Google Translate TTS nếu chưa có
    unless voc.audio.attached?
      begin
        audio_url = "https://translate.google.com/translate_tts?ie=UTF-8&q=#{URI.encode_www_form_component(v[:word])}&tl=ja&client=tw-ob"
        audio_file = URI.open(audio_url, "User-Agent" => "Mozilla/5.0")
        voc.audio.attach(io: audio_file, filename: "#{v[:word]}.mp3", content_type: "audio/mpeg")
        print " [Audio OK]"
      rescue => audio_err
        print " [Audio Error: #{audio_err.message}]"
      end
    end

    puts "OK: #{v[:word]}"
  rescue => e
    puts "ERROR: #{v[:word]} - #{e.message}"
  end
end

puts "Seeded #{Vocabulary.count} vocabs 🌸"


# db/seeds.rb

kanjis = [
  {
    character: "一",
    onyomi: "イチ、イツ",
    kunyomi: "ひと",
    meaning: "một",
    stroke_count: 1,
    jlpt_level: "N5"
  },
  {
    character: "二",
    onyomi: "ニ",
    kunyomi: "ふた",
    meaning: "hai",
    stroke_count: 2,
    jlpt_level: "N5"
  },
  {
    character: "三",
    onyomi: "サン",
    kunyomi: "み",
    meaning: "ba",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "四",
    onyomi: "シ",
    kunyomi: "よん、よ",
    meaning: "bốn",
    stroke_count: 5,
    jlpt_level: "N5"
  },
  {
    character: "五",
    onyomi: "ゴ",
    kunyomi: "いつ",
    meaning: "năm",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "六",
    onyomi: "ロク",
    kunyomi: "む",
    meaning: "sáu",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "七",
    onyomi: "シチ",
    kunyomi: "なな",
    meaning: "bảy",
    stroke_count: 2,
    jlpt_level: "N5"
  },
  {
    character: "八",
    onyomi: "ハチ",
    kunyomi: "や",
    meaning: "tám",
    stroke_count: 2,
    jlpt_level: "N5"
  },
  {
    character: "九",
    onyomi: "キュウ、ク",
    kunyomi: "ここの",
    meaning: "chín",
    stroke_count: 2,
    jlpt_level: "N5"
  },
  {
    character: "十",
    onyomi: "ジュウ",
    kunyomi: "とお",
    meaning: "mười",
    stroke_count: 2,
    jlpt_level: "N5"
  },
  {
    character: "百",
    onyomi: "ヒャク",
    kunyomi: "",
    meaning: "trăm",
    stroke_count: 6,
    jlpt_level: "N5"
  },
  {
    character: "千",
    onyomi: "セン",
    kunyomi: "",
    meaning: "nghìn",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "万",
    onyomi: "マン",
    kunyomi: "",
    meaning: "mười nghìn",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "円",
    onyomi: "エン",
    kunyomi: "まる",
    meaning: "yên nhật",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "人",
    onyomi: "ジン、ニン",
    kunyomi: "ひと",
    meaning: "người",
    stroke_count: 2,
    jlpt_level: "N5"
  },
  {
    character: "日",
    onyomi: "ニチ、ジツ",
    kunyomi: "ひ、か",
    meaning: "ngày, mặt trời",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "月",
    onyomi: "ゲツ、ガツ",
    kunyomi: "つき",
    meaning: "tháng, mặt trăng",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "火",
    onyomi: "カ",
    kunyomi: "ひ",
    meaning: "lửa",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "水",
    onyomi: "スイ",
    kunyomi: "みず",
    meaning: "nước",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "木",
    onyomi: "モク、ボク",
    kunyomi: "き",
    meaning: "cây",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "金",
    onyomi: "キン",
    kunyomi: "かね",
    meaning: "vàng, tiền",
    stroke_count: 8,
    jlpt_level: "N5"
  },
  {
    character: "土",
    onyomi: "ド、ト",
    kunyomi: "つち",
    meaning: "đất",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "山",
    onyomi: "サン",
    kunyomi: "やま",
    meaning: "núi",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "川",
    onyomi: "セン",
    kunyomi: "かわ",
    meaning: "sông",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "田",
    onyomi: "デン",
    kunyomi: "た",
    meaning: "ruộng",
    stroke_count: 5,
    jlpt_level: "N5"
  },
  {
    character: "学",
    onyomi: "ガク",
    kunyomi: "まなぶ",
    meaning: "học",
    stroke_count: 8,
    jlpt_level: "N5"
  },
  {
    character: "生",
    onyomi: "セイ、ショウ",
    kunyomi: "いきる、うまれる",
    meaning: "sống, sinh",
    stroke_count: 5,
    jlpt_level: "N5"
  },
  {
    character: "先",
    onyomi: "セン",
    kunyomi: "さき",
    meaning: "trước",
    stroke_count: 6,
    jlpt_level: "N5"
  },
  {
    character: "私",
    onyomi: "シ",
    kunyomi: "わたし",
    meaning: "tôi",
    stroke_count: 7,
    jlpt_level: "N5"
  },
  {
    character: "時",
    onyomi: "ジ",
    kunyomi: "とき",
    meaning: "giờ",
    stroke_count: 10,
    jlpt_level: "N5"
  },
  {
    character: "分",
    onyomi: "ブン、フン",
    kunyomi: "わかる",
    meaning: "phút, phần",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "半",
    onyomi: "ハン",
    kunyomi: "なか",
    meaning: "một nửa",
    stroke_count: 5,
    jlpt_level: "N5"
  },
  {
    character: "上",
    onyomi: "ジョウ",
    kunyomi: "うえ",
    meaning: "trên",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "下",
    onyomi: "カ、ゲ",
    kunyomi: "した",
    meaning: "dưới",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "中",
    onyomi: "チュウ",
    kunyomi: "なか",
    meaning: "giữa",
    stroke_count: 4,
    jlpt_level: "N5"
  },
  {
    character: "大",
    onyomi: "ダイ、タイ",
    kunyomi: "おお",
    meaning: "to, lớn",
    stroke_count: 3,
    jlpt_level: "N5"
  },
  {
    character: "小",
    onyomi: "ショウ",
    kunyomi: "ちい",
    meaning: "nhỏ",
    stroke_count: 3,
    jlpt_level: "N5"
  }
]

kanjis.each do |kanji|
  Kanji.find_or_create_by!(character: kanji[:character]) do |k|
    k.onyomi = kanji[:onyomi]
    k.kunyomi = kanji[:kunyomi]
    k.meaning = kanji[:meaning]
    k.stroke_count = kanji[:stroke_count]
    k.jlpt_level = kanji[:jlpt_level]
  end
end

puts "Seeded #{Kanji.count} kanjis!"