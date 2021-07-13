require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it 'ニックネーム、メールアドレス、パスワード、名字と名前、名字と名前のカナが存在すれば登録できること' do
    expect(@user).to be_valid
  end

  it 'ニックネームが空では登録できないこと' do
    @user.nickname = ''
    @user.valid?
    expect(@user.errors.full_messages).to include "Nickname can't be blank"
  end

  it 'メールアドレスが空では登録できないこと' do
    @user.email = ""
    @user.valid?
    expect(@user.errors.full_messages).to include "Email can't be blank"
  end

  it 'パスワードが空では登録できないこと' do
    @user.password = ""
    @user.valid?
    expect(@user.errors.full_messages).to include "Password can't be blank"
  end

  it '名字が空では登録できないこと' do
    @user.last_name = ""
    @user.valid?
    expect(@user.errors.full_messages).to include "Last name can't be blank"
  end

  it '名前が空では登録できないこと' do
    @user.first_name = ""
    @user.valid?
    expect(@user.errors.full_messages).to include "First name can't be blank"
  end

  it '名字のカナが空では登録できないこと' do
    @user.last_name_kana = ""
    @user.valid?
    expect(@user.errors.full_messages).to include "Last name kana can't be blank"
  end

  it '名前のカナが空では登録できないこと' do
    @user.first_name_kana = ""
    @user.valid?
    expect(@user.errors.full_messages).to include "First name kana can't be blank"
  end

  it '生年月日が空では登録できないこと' do
    @user.birthday = ""
    @user.valid?
    expect(@user.errors.full_messages).to include "Birthday can't be blank"
  end

  it '重複したメールアドレスが存在すると登録できないこと' do
    @user.save
    another_user = FactoryBot.build(:user, email: @user.email)
    another_user.valid?
    expect(another_user.errors.full_messages).to include('Email has already been taken')
  end

  it 'passwordが6文字以上であれば登録できること' do
    @user.password = '123aaa'
    @user.password_confirmation = '123aaa'
    expect(@user).to be_valid
  end

  it 'passwordが5文字以下であれば登録できないこと' do
    @user.password = '123ab'
    @user.password_confirmation = '123ab'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
  end

  it 'パスワードが半角英数字混合でない場合登録できないこと' do
    @user.password = '123456'
    @user.password_confirmation = '123456'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    @user.password = 'aaaaaa'
    @user.password_confirmation = 'aaaaaa'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
  end

  it 'passwordとpassword_confirmationが不一致では登録できないこと' do
    @user.password = '123abc'
    @user.password_confirmation = 'abc123'
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it '名字が全角で入力されていない場合登録できないこと' do
    @user.last_name = "abc"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")

  end

  it '名前が全角で入力されていない場合登録できないこと' do
    @user.first_name = "abc"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")

  end

  it '名字のカナがカタカナで入力されていない場合登録できないこと' do
    @user.last_name_kana = "abc"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
    @user.last_name_kana = "てすと"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
    @user.last_name_kana = "鬱"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
  end

  it '名前のカナがカタカナで入力されていない場合登録できないこと' do
    @user.first_name_kana = "abc"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
    @user.first_name_kana = "てすと"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
    @user.first_name_kana = "鬱"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")

  end
end
