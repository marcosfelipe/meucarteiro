class Shipment < ActiveRecord::Base

  belongs_to :user
  has_one :shipment_text
  has_one :shipment_email
  has_many :shipment_contacts

  #fattening -> inserindo na tabela shipment_contacts
  #ready -> pronto para enviar
  #sending -> enviando
  #done -> enviou para todos os contatos
  enum status: { fattening:0, ready: 1, sending: 2, done:3 }

  validates :name, presence: true

  accepts_nested_attributes_for :shipment_text, :shipment_email


  scope :fattening, -> { where status: statuses[:fattening] }
  scope :ready, -> { where status: statuses[:ready] }
  scope :sending, -> { where status: statuses[:sending] }
  scope :done, -> { where status: statuses[:done] }
  scope :pending, -> { where "status in (?,?,?)", statuses[:fattening], statuses[:ready], statuses[:sending] }




end
