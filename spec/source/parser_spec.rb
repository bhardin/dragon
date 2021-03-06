require "spec_helper"

describe Dragon::Parser do
  let(:parser) { described_class.new }

  describe "#comment" do
    it "parses # Foo Bar" do
      expect(parse(:comment, "# Foo Bar")).to eq("# Foo Bar")
    end
    it "parses #" do
      expect(parse(:comment, "#")).to eq("#")
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
end
