class DBManager
  def initialize
    @db = SQLite3::Database.new(File.join(NSBundle.mainBundle.resourcePath, "db.sqlite"))
  end

  def execute_in_transaction(&block)
    begin
      @db.execute("BEGIN TRANSACTION;")
      result = yield
      @db.execute("COMMIT;")
      result
    rescue SQLite3::Exception => e
      puts "Error executing transaction: #{e}"
      @db.execute("ROLLBACK;")
      nil
    end
  end

  def get_users
    execute_in_transaction { @db.execute("SELECT * FROM users") }
  end

  def get_apartments
    execute_in_transaction { @db.execute("SELECT * FROM apartments") }
  end

  def get_contracts
    execute_in_transaction { @db.execute("SELECT * FROM contracts") }
  end

  def find_user_by_email(email)
    execute_in_transaction { @db.execute("SELECT * FROM users WHERE email = '#{email}'") }
  end

  def add_user(name, email, password, phone_number)
    execute_in_transaction do
      @db.execute(
        "INSERT INTO users (name, email, password, phone_number) VALUES (?, ?, ?, ?)",
        [name, email, password, phone_number]
      )
    end
  end

  def add_contract(user_id, apartment_id, monthly_bill, rental_period)
    execute_in_transaction do
      @db.execute(
        "INSERT INTO contracts (monthly_bill, rental_period, user_id, apartment_id) VALUES (?, ?, ?, ?)",
        [monthly_bill, rental_period, user_id, apartment_id]
      )
    end
  end

  def find_free_apartments
    execute_in_transaction do
      @db.execute(
        "SELECT * FROM apartments
         WHERE apartments.id NOT IN
         (SELECT contracts.id_apartment FROM contracts);"
      )
    end
  end

  def find_rented_apartments_for_user(user_id)
    execute_in_transaction do
      @db.execute(
        "SELECT * FROM apartments
         WHERE apartments.id IN
         (SELECT contracts.id_apartment FROM contracts WHERE contracts.id_user = #{user_id})"
      )
    end
  end

  def find_contract(id_apartment)
    execute_in_transaction { @db.execute("SELECT * FROM contracts WHERE id_apartment = #{id_apartment}") }
  end

  def make_rent(user_id, apartment_id, amount)
    execute_in_transaction do
      @db.execute(
        'INSERT INTO contracts (id_user, id_apartment, monthly_bill, rental_period) VALUES (?, ?, ?, ?)',
        [user_id, apartment_id, amount, 1]
      )
    end
  end

  def get_bill(contract_id)
    execute_in_transaction do
      @db.execute(
        "SELECT * FROM bills WHERE bills.id_contract = #{contract_id}"
      )
    end
  end
  def set_bill(id_contract, params={})
    execute_in_transaction do
      @db.execute(
        'UPDATE bills SET rent = ?, electricity = ?, garbage = ?, cold_water = ?, hot_water = ? WHERE id_contract = ?',
        [params[:rent], params[:electricity], params[:garbage], params[:cold_water], params[:hot_water], id_contract]
      )
    end
  end

  def paid_bill(id_contract)
    execute_in_transaction do
      @db.execute(
        'UPDATE bills SET rent = 0, electricity = 0, garbage = 0, cold_water = 0, hot_water = 0 WHERE id_contract = ?',
        [id_contract]
      )
    end
  end
end
