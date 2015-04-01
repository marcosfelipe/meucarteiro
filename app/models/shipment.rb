class Shipment < ActiveRecord::Base

  belongs_to :user
  has_one :shipment_text
  has_many :shipment_contacts

  #fattening -> inserindo na tabela shipment_contacts
  #ready -> pronto para enviar
  #sending -> enviando
  #done -> enviou para todos os contatos
  enum status: { fattening:0, ready: 1, sending: 2, done:3 }

  validates :name, presence: true

  accepts_nested_attributes_for :shipment_text


end
