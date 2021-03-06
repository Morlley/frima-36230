require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context "商品を出品できる" do
    it "商品名・商品の説明・カテゴリー・商品の状態・配送料の負担・発送元の地域・発送までの日数・価格の情報と画像が存在していれば出品できること" do
      expect(@item).to be_valid
    end
  end

  context "商品を出品できない" do
    it '商品名が空では登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Name can't be blank"
    end

    it '商品の説明が空では登録できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Description can't be blank"
    end

    it 'カテゴリーが空では登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Category can't be blank"
    end

    it '商品の状態の説明が空では登録できない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Condition can't be blank"
    end

    it '配送料の負担の情報が空では登録できない' do
      @item.shipping_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping fee can't be blank"
    end

    it '発送元の地域の情報が空では登録できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture can't be blank"
    end

    it '発送までの日数の情報が空では登録できない' do
      @item.shipment_date_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipment date can't be blank"
    end

    it '価格の情報が空では登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
    end

    it '画像が空では登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
    end

    it '299円以下では登録できないこと' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is out of setting range"
    end

    it '10000000以上では登録できないこと' do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is out of setting range"
    end

    it '価格が英字の場合は登録できない' do
      @item.price = "abc"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is out of setting range"
    end

    it '価格が全角数字の場合は登録できない' do
      @item.price = "１２３"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is out of setting range"
    end

    it '価格が全角文字の場合は登録できない' do
      @item.price = "テスト"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is out of setting range"
    end


    it '価格が半角英数混合の場合は登録できない' do
      @item.price = "123abc"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is out of setting range"
    end

    it 'userが紐付いていない場合は登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "User must exist"
    end
  end
end
