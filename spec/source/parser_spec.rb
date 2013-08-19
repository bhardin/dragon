require "spec_helper"

describe Dragon::Parser do
  let(:parser) { described_class.new }

  describe "#space" do
    it "parses space" do
      expect(parse(:space, "\s")).to eq("\s")
    end

    it "parses tab" do
      expect(parse(:space, "\t")).to eq("\t")
    end
  end

  describe "#newline" do
    it "parses windows return" do
      expect(parse(:newline, "\r")).to eq("\r")
    end

    it "parses unix return" do
      expect(parse(:newline, "\n")).to eq("\n")
    end
  end

  describe "#white_space" do
    it "parses multiple spaces" do
      expect(parse(:white_space, "\s\s")).to eq("\s\s")
    end

    it "parses multiple returns" do
      expect(parse(:white_space, "\r\r")).to eq("\r\r")
    end
  end

  describe "#upper_letter" do
    it "parses A" do
      expect(parse(:upper_letter, "A")).to eq("A")
    end

    it "parses M" do
      expect(parse(:upper_letter, "M")).to eq("M")
    end

    it "parses Z" do
      expect(parse(:upper_letter, "Z")).to eq("Z")
    end
  end

  describe "#lower_letter" do
    it "parses a" do
      expect(parse(:lower_letter, "a")).to eq("a")
    end

    it "parses m" do
      expect(parse(:lower_letter, "m")).to eq("m")
    end

    it "parses z" do
      expect(parse(:lower_letter, "z")).to eq("z")
    end
  end


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





