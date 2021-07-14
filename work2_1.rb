# irb
# require '/Users/yumiko/Desktop/work/ruby_book/work/work2_1.rb'
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new

# 作成した自動販売機に1000円を入れる
# vm.slot_money (1000)
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money

class VendingMachine
# ステップ０　お金の投入と払い戻しの例コード
# ステップ１　扱えないお金の例コード
# 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
# （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
# 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    @drink_information = {cola: {price: 120, stock: 5}, redbull: {price: 200, stock: 5}, water: {price: 100, stock: 5}}
    # @drink_information[:cola]=>{price: 120, stock: 5}
    # @drink_information[:cola][:stock]=> 5
    @sale_amount = 0
  end
# 投入金額の総計を取得できる。
  def current_slot_money
# 自動販売機に入っているお金を表示する
    @slot_money
  end
# 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
# 投入は複数回できる。
  def slot_money(money)
# 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
# が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
# 自動販売機にお金を入れる
    @slot_money += money
  end
# 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money
  def return_money
# 返すお金の金額を表示する
    puts @slot_money
# 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
# vm.drink_information(:cola)
# vm.drink_information(:redbull)
# vm.drink_information(:water)
# ドリンク情報
  def drink_information(drink)
    @drink_information[drink]
  end
# ドリンク登録
# vm.drink_register(:cola)
  def drink_register(drink)
    if drink == :all
      @drink_information[cola][:stock] = 5
      @drink_information[redbull][:stock] = 5
      @drink_information[water][:stock] = 5
    else
      @drink_information[drink][:stock] = 5
    end
  end
# 投入金額、在庫の点でコーラが購入できるかどうか取得できる
# vm.drink_buy?(:cola)
  def drink_buy?(drink)
    if current_slot_money >= @drink_information[drink][:price] && @drink_information[drink][:stock] > 0
      return true
    else
      return false
    end
  end
# 売り上げ金額
# vm.sale_amount
  def sale_amount
    @sale_amount
  end
# 購入操作を行うと在庫を減らし、売り上げ金額をふやす
# vm.drink_stock_sale_amout(:cola)
# vm.drink_information(:cola)
# vm.sale_amount
  def drink_stock_sale_amout(drink)
    if drink_buy?(drink)
      @drink_information[drink][:stock] -= 1
      @sale_amount += @drink_information[drink][:price]
      @refund = @slot_money -= @drink_information[drink][:price]
    else
      return false
    end
  end
# 投入金額が足りない場合もしくは在庫がない場合、購入操作を行っても何もしない
# vm.current_slot_money
# vm.not_drink_buy(:cola)
  def not_drink_buy(drink)
    if current_slot_money < @drink_information[drink][:price] || @drink_information[drink][:stock] == 0
      return false
    else
      return true
    end
  end
# 払い戻し操作では現在の投入金額からジュース購入金額を引いた釣り銭を出力する。
# vm.drink_stock_sale_amout(:cola)
# vm.drink_information(:cola)
  def drink_stock_sale_amout(drink)
    if drink_buy?(drink)
      @drink_information[drink][:stock] -= 1
      @sale_amount += @drink_information[drink][:price]
      @refund = @slot_money -= @drink_information[drink][:price]
    else
      return false
    end
  end
#  投入金額、在庫の点で購入可能なドリンクのリストを取得できる
# vm.current_slot_money
# vm.list_available_buy(:cola)
  def list_available_buy(drink)
    if current_slot_money > @drink_information[drink][:price] && @drink_information[drink][:stock] > 0
      puts "買えますよ"
    else
      puts "売り切れです"
    end
  end
# ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、釣り銭（投入金額とジュース値段の差分）を出力する。
# vm.drink_information(:cola)
# vm.change(:cola)
  def change(drink)
    if current_slot_money > @drink_information[drink][:price]
      @refund
    elsif
      current_slot_money = @drink_information[drink][:price]
      puts "0円です"
    end
  end
end
