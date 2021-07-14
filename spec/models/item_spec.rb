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
      @item.category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Category can't be blank"
    end

    it '商品の状態の説明が空では登録できない' do
      @item.condition_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Condition can't be blank"
    end

    it '配送料の負担の情報が空では登録できない' do
      @item.shipping_fee_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping fee can't be blank"
    end

    it '発送元の地域の情報が空では登録できない' do
      @item.prefecture_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture can't be blank"
    end

    it '発送までの日数の情報が空では登録できない' do
      @item.shipment_date_id = ''
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

    it '価格が指定範囲外の数字の場合は登録できない' do
      @item.price = "299"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is out of setting range"
      @item.price = "10000000"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is out of setting range"
    end

    it '価格が半角数値でない場合は登録できない' do
      @item.price = "abc"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is invalid. Input half-width characters"
      @item.price = "１２３"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is invalid. Input half-width characters"
      @item.price = "テスト"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price is invalid. Input half-width characters"
    end

    it 'userが紐付いていない場合は登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "User must exist"
    end
  end
end
