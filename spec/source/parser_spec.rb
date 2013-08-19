require "spec_helper"

describe Dragon::Parser do
  let(:parser) { described_class.new }


  describe "#decimal" do
    it "parses 1.0" do
      expect(parse(:decimal, "1.0")).to eq("1.0")
    end

    it "parses 10.005" do
      expect(parse(:decimal, "10.005")).to eq("10.005")
    end

    it "parses 0.5" do
      expect(parse(:decimal, "0.5")).to eq("0.5")
    end

    it "parses 0.5555" do
      expect(parse(:decimal, "0.5555")).to eq("0.5555")
    end
  end

  describe "#comment" do
    it "parses # Foo Bar" do
      expect(parse(:comment, "# Foo Bar")).to eq("# Foo Bar")
    end
    it "parses #" do
      expect(parse(:comment, "#")).to eq("#")
    end
  end

  describe "#integer" do
    it "parses 1" do
      expect(parse(:integer, "1")).to eq("1")
    end

    it "parses 5" do
      expect(parse(:integer, "5")).to eq("5")
    end

    it "parses 9" do
      expect(parse(:integer, "9")).to eq("9")
    end
  end

  describe "#symbol" do
    it "parses ?" do
      expect(parse(:symbol, "?")).to eq("?")
    end

    it "parses !" do
      expect(parse(:symbol, "!")).to eq("!")
    end

    it "parses _" do
      expect(parse(:symbol, "_")).to eq("_")
    end

    it "parses @" do
      expect(parse(:symbol, "@")).to eq("@")
    end

    it "parses $" do
      expect(parse(:symbol, "$")).to eq("$")
    end

    it "parses %" do
      expect(parse(:symbol, "%")).to eq("%")
    end

    it "parses ^" do
      expect(parse(:symbol, "^")).to eq("^")
    end

    it "parses &" do
      expect(parse(:symbol, "&")).to eq("&")
    end

    it "parses /" do
      expect(parse(:symbol, "/")).to eq("/")
    end

    it "parses \\" do
      expect(parse(:symbol, "\\")).to eq("\\")
    end
    it "parses ~" do
      expect(parse(:symbol, "~")).to eq("~")
    end

    it "parses -" do
      expect(parse(:symbol, "-")).to eq("-")
    end

    it "parses |" do
      expect(parse(:symbol, "|")).to eq("|")
    end

    it "parses =" do
      expect(parse(:symbol, "=")).to eq("=")
    end

    it "parses *" do
      expect(parse(:symbol, "*")).to eq("*")
    end

    it "parses <" do
      expect(parse(:symbol, "<")).to eq("<")
    end

    it "parses >" do
      expect(parse(:symbol, ">")).to eq(">")
    end

    it "parses ;" do
      expect(parse(:symbol, ";")).to eq(";")
    end

    it "parses +" do
      expect(parse(:symbol, "+")).to eq("+")
    end
  end

  describe "#zero" do
    it "parses 0" do
      expect(parse(:zero, "0")).to eq("0")
    end
  end

  describe "#single_quoted" do
    it "parses 'Foo'" do
      expect(parse(:single_quoted, "'Foo'")).to eq("'Foo'")
    end
  end

  describe "#double_quoted" do
    it "parses \"Foo\"" do
      expect(parse(:double_quoted, "\"Foo\"")).to eq("\"Foo\"")
    end
  end

  describe "#negative" do
    it "parses -1" do
      expect(parse(:negative, "-1")).to eq("-1")
    end

    it "parses -55" do
      expect(parse(:negative, "-55")).to eq("-55")
    end

    it "parses -1.0" do
      expect(parse(:negative, "-1.0")).to eq("-1.0")
    end

    it "parses -1.55" do
      expect(parse(:negative, "-1.55")).to eq("-1.55")
    end
  end

  describe "#word"
  describe "#line"
  describe "#message"
  describe "#argument"
  describe "#close"
  describe "#open"
  describe "#definition"
  describe "#expression"
  describe "#function"
end





