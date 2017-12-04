require 'active_record'

ActiveRecord::Base.establish_connection(
	"adapter" => "sqlite3",
	"database" => "db/development.sqlite3"
)

class Stock < ApplicationRecord

	def self.import(file)
		#ヘッダのコンバート処理
		header_to_sym_map = {
			'日付' => :date,
			'始値' => :opening_price,
			'高値' => :high_price,
			'安値' => :low_price,
			'終値' => :closing_price,
			'出来高' => :turnover_value,
			'売買代金' => :turnover_price
		}

		header_converter = lambda { |h| header_to_sym_map[h] }

		#SJIS->UTF-8でエンコーディング
		open(file.path, encoding: "Shift_JIS:UTF-8", undef: :replace) do |f|
			csv = CSV.new(f, headers: :first_row, header_converters: header_converter)
			csv.each do |row|
				#同じ日が見つかればレコードを呼び出し、見つからなければ新しく作成
				stock = find_by(date: row[:date]) || new
				#csvからデータを取得し、設定する
				stock.attributes = row.to_hash.slice(*uppdatable_attributes)
				#保存
				stock.save!
			end
		end
	end

	#更新を許可するカラムの定義
	def self.uppdatable_attributes
		[:date, :opening_price, :high_price, :low_price, :closing_price, :turnover_value, :turnover_price]
	end

end
