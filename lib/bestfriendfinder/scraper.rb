require_relative '../../config/environment'

class BestFriendFinder::Scraper

  def self.scrape_adoptable_pets(animal)
    pets = []
    doc = Nokogiri::HTML(open("http://bestfriends.org/adopt/adopt-our-sanctuary/#{animal}"))
    doc.css("div.rg-animal").each do |pet|
      pet_details = {}
      pet_details[:name] = pet.css("span.animalName").text
      pet_details[:breed] = pet.css("span.animalBreed").text
      pet_details[:age] = pet.css("span.animalAge").text
      pet_details[:url] = pet.css("a").attribute("href").value
      pets << pet_details
    end
    pets
  end

  def self.find_details_url(pet_name) #remove this!
    doc = Nokogiri::HTML(open("http://bestfriends.org/adopt/adopt-our-sanctuary/#{animal}"))
    # Take the pet's name, scrape the main pet page and look for the CSS tag.text that equal the same name.
    # Once you have found that, pass that URL into a new Scraper method to scrape_pet_profile
    # Return hash of pet profile information
    pet_name
  end

  def self.scrape_pet_profile(url)
    pet_profile_details = {}

    dog_profile = "http://bestfriends.org" + url
    doc = Nokogiri::HTML(open(dog_profile))
    pet_items = doc.css("div.rescue-groups-pet-info-item")

    pet_items.each do |attribute|
      if attribute.css("span.gray").text == "Size:"
        pet_profile_details[:size] = attribute.css("span.bold.black").text
      elsif attribute.css("span.gray").text == "Color:"
        pet_profile_details[:color] = attribute.css("span.bold.black").text
      elsif attribute.css("span.gray").text == "Sex:"
        pet_profile_details[:sex] = attribute.css("span.bold.black").text
      end
    end
    pet_profile_details
  end
end
