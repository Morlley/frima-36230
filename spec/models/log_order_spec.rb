require 'rails_helper'

RSpec.describe LogOrder, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @log_order = FactoryBot.build(:log_order,user_id: user.id, item_id: item.id)
    sleep(0.1)
  end

  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@log_order).to be_valid
    end
    it '建物名は空でも保存できること' do
      @log_order.address_line2 = ""
      expect(@log_order).to be_valid
    end
    it "電話番号は10桁でも保存できること" do
      @log_order.phone_number = "1234567891"
      expect(@log_order).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "郵便番号が空では保存できないこと" do
      @log_order.postal_code = ""
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include("Postal code can't be blank")
    end

    it "郵便番号にハイフンが含まれていない場合保存できないこと" do
      @log_order.postal_code = "1234567"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it "郵便番号が全角数字の場合保存できないこと" do
      @log_order.postal_code = "１２３ー４５６７"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it "郵便番号が全角文字列の場合保存できないこと" do
      @log_order.postal_code = "やあやあ"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it "郵便番号が英字の場合保存できないこと" do
      @log_order.postal_code = "abcdefg"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it "都道府県はid: 1を選択した場合保存できないこと" do
      @log_order.prefecture_id = 1
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Prefecture can't be blank"
    end

    it "都道府県が空の場合保存できないこと" do
      @log_order.prefecture_id = ""
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Prefecture can't be blank"
    end

    it "市区町村が空の場合保存できないこと" do
      @log_order.city = ""
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "City can't be blank"
    end

    it "番地が空の場合保存できないこと" do
      @log_order.address_line1 = ""
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Address line1 can't be blank"
    end

    it "電話番号が空の場合保存できないこと" do
      @log_order.phone_number = ""
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Phone number can't be blank"
    end

    it "電話番号が10桁未満の場合保存できないこと" do
      @log_order.phone_number = "12345"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Phone number is too short"
    end

    it "電話番号にハイフンが含まれている場合保存できないこと" do
      @log_order.phone_number = "090-1234-5678"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Phone number is invalid. Input only number"
    end

    it "電話番号が全角数字の場合保存できないこと" do
      @log_order.phone_number = "０９０１２３４５６７８"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Phone number is invalid. Input only number"
    end

    it "電話番号が全角文字列の場合保存できないこと" do
      @log_order.phone_number = "やあやあやあやあやあ"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Phone number is invalid. Input only number"
    end

    it "電話番号が英字の場合保存できないこと" do
      @log_order.phone_number = "abcdefghij"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Phone number is invalid. Input only number"
    end

    it "電話番号が英数字の混合の場合保存できないこと" do
      @log_order.phone_number = "1234567hij"
      @log_order.valid?
      expect(@log_order.errors.full_messages).to include "Phone number is invalid. Input only number"
    end
  end

end