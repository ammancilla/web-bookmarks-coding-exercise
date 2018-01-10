class RemoveProtocolAndHostnameAttributesFromSite < ActiveRecord::Migration[5.1]
  def change
    remove_column :sites, :protocol, :integer
    remove_column :sites, :hostname, :string
  end
end
