class CountryValidator < ActiveModel::Validator
	def validate(record)
		splitted_vat_number = Valvat::Utils.split(record.vat_number)

		if not splitted_vat_number[0] == 'AT'
			record.errors[:vat_number] << I18n.t('errors.not_from_austria')
		end
	end
end