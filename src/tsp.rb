INF = Float::INFINITY

# ================= FUNGSI UTAMA TSP =================
def tsp(graph)
  n = graph.size
  dp = Array.new(1 << n) { Array.new(n, INF) } # Biaya minimum untuk mengunjungi subset mask dan berakhir di kota u
  parent = Array.new(1 << n) { Array.new(n, -1) } # Kota sebelum u dalam rute subset mask
  dp[1][0] = 0  # Mulai dari kota 0

  (1 << n).times do |mask|
    n.times do |u|
      next if dp[mask][u] == INF # State belum pernah dicapai

      n.times do |v|
        # Lewati jika kota v sudah dikunjungi atau tidak ada edge dari u ke v
        next if (mask & (1 << v)) != 0
        next if graph[u][v] == INF

        next_mask = mask | (1 << v) # Update subset kota yang dikunjungi
        new_cost = dp[mask][u] + graph[u][v]
        # Update dp dan parent jika menemukan biaya lebih murah
        if new_cost < dp[next_mask][v]
          dp[next_mask][v] = new_cost
          parent[next_mask][v] = u
        end
      end
    end
  end

  # Cari rute minimum yang kembali ke kota awal
  final_cost = INF
  last_city = -1
  full_mask = (1 << n) - 1

  n.times do |i|
    next if graph[i][0] == INF # Pastikan bisa kembali ke kota 0
    cost = dp[full_mask][i] + graph[i][0]
    if cost < final_cost
      final_cost = cost
      last_city = i
    end
  end

  if final_cost == INF
    return [INF, []]
  end

  # Rekonstruksi path
  path = []
  mask = full_mask
  city = last_city

  while city != -1
    path << city
    prev_city = parent[mask][city]
    mask = mask ^ (1 << city) # Hapus kota dari subset mask
    city = prev_city
  end

  path.reverse!
  path << 0 # Tambahkan kota awal hanya sebagai titik akhir tur


  [final_cost, path]
end

# ================= INPUT FILE HANDLING =================
def read_graph_from_file(filename)
  unless File.exist?(filename)
    puts "File '#{filename}' tidak ditemukan!"
    exit
  end

  lines = File.readlines(filename).map(&:strip).reject(&:empty?)
  n = lines[0].to_i

  if lines.size != n + 1
    puts "Format file salah: harus ada #{n} baris data matriks setelah baris jumlah kota!"
    exit
  end

  graph = []
  (1..n).each do |i|
    row = lines[i].split.map(&:to_i)
    if row.size != n
      puts "Baris ke-#{i} tidak memiliki #{n} angka!"
      exit
    end
    graph << row
  end

  # Ubah -1 menjadi INF kecuali diagonal
  graph.each_with_index do |row, i|
    row.each_with_index do |val, j|
      if val == -1 && i != j
        row[j] = INF
      end
    end
  end

  graph
end

# ================= MAIN =================
puts "Masukkan nama file input:"
input_filename = gets.strip
base_dir = File.expand_path(File.dirname(__FILE__))
input_path = File.join(base_dir, "..", "test", "input", input_filename)

graph = read_graph_from_file(input_path)
hasil, path = tsp(graph)

if hasil == INF
  puts "Tidak ada rute yang menyelesaikan TSP"
else
  puts "Biaya minimum untuk menyelesaikan TSP adalah: #{hasil}"
  puts "Rute yang dilalui: #{path.map { |kota| kota + 1 }.join(' -> ')}"
end