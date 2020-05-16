require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do

    # ユーザー情報
    it "ニックネーム必須" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "email必須" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.erroes[:email]).to include("が入力されていません")
    end

    it "メールアドレスは一意である" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("は既に使用されています。")
    end

    it "メールアドレスは@とドメインを含む必要がある" do
      user = build(:user, email: "furimatest.com")
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")
      user = build(:user, email: "furima@")
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")
    end

    it "passwordが必須" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    it "passwordは７文字以上必要" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが６文字以下だと登録出来ない" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上に設定して下さい。")
    end

    it "passwordは確認用を含めて2回入力する" do
      user = build(:user, password: "1234567", password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # 本人確認情報

    it "ユーザー本名の苗字が必須" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it "ユーザー本名の名前が必要" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    it "ユーザー本名の苗字がふりがなで必須" do
      user = build(:user,first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    it "ユーザー本名の名前がふりがなで必要" do
      user = build(:user,last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください")
    end

    it "生年月日が必須" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

  end
end