Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
	"Fiecht-Au 31, 6134, Vomp", [
		{
			'latitude'     => 47.358423,
			'longitude'    => 11.703437,
			'address'      => 'Fiecht-Au 31, 6134, Vomp',
			'country'      => 'Austria',
			'country_code' => 'AT'
		}
	]
)

FactoryGirl.define do
	factory :company do
		name "Test Company"
		email "test@vendox.net"
		password "securE#Password11-2"
		street "Fiecht-Au 31"
		zip_code "6134"
		locality "Vomp"
		phone_number "012223456789"
		vat_number "ATU51197404"
	end
end