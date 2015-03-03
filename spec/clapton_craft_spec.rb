require "./spec/spec_helper"
require "./lib/clapton_craft"

describe ClaptonCraft do
  it "can be initialized with a uri" do
    clapton_craft = ClaptonCraft.new("http://google.com")
    clapton_craft.must_be_instance_of ClaptonCraft
  end

  it "can be initialized with a filepath" do
    clapton_craft = ClaptonCraft.new("./spec/fixtures/clapton_craft.html")
    clapton_craft.must_be_instance_of ClaptonCraft
  end

  it "requires a uri" do
    lambda { ClaptonCraft.new }.must_raise ArgumentError
  end

  describe "#growlers and #bottles" do
    before :each do
      @clapton_craft = ClaptonCraft.new("./spec/fixtures/clapton_craft.html")
    end

    it "should return a list of growlers" do
      @clapton_craft.growlers.must_be_instance_of Array
    end

    it "should return a list of bottles" do
      @clapton_craft.bottles.must_be_instance_of Array
    end

    it "should return the growlers from the HTML page" do
      @clapton_craft.growlers.must_equal ["Burning Sky Session IPA", "Four Pure Oatmeal Stout", "Wild Beer Co Madness IPA", "Siren 7 Seas Black IPA"]
    end

    it "should return the bottles from the HTML page" do
      @clapton_craft.bottles.must_equal ["THe Kernel Pale Ale Citra", "Bob Barley Barley Wine", "Holy Cowbell India Stout", "Crate Lager"]
    end
  end
end
