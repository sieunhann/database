### 1. Lấy thông tin các bộ phim gồm: tiêu đề, mô tả, tên đạo diễn, tên biên kịch (bảng writers - trả về dạng array), độ dài, rating, của các bộ phim thuộc loại ‘Movie’.
``` SQL
SELECT m.title, m.description, d.full_name AS director, json_arrayagg(w.full_name) AS writer, m.length, m.rating, tt.name
FROM movie m 
INNER JOIN director d ON m.id_director = d.id
INNER JOIN movie_writers mw ON m.id = mw.id_movie
INNER JOIN writers w ON w.id = mw.id_writer
INNER JOIN title_type tt ON m.id_title_type = tt.id
WHERE tt.name LIKE 'Movie'
GROUP BY m.id;
```
![alt](/image/1.png)

### 2. Liệt kê các hãng phim (Bảng manufacturer) và số lượng phim thuộc hãng đó
```SQL
SELECT manu.name, COUNT(m.id)
FROM manufacturer manu
LEFT JOIN movie_manufacturer mm ON manu.id = mm.id_manufacturer
LEFT JOIN movie m ON mm.id_movie = m.id
GROUP BY manu.id;
```

![alt](/image/2.png)

### 3. Liệt kê các phim thuộc loại TV Series đã hoàn thành (current_episode = episode)
```SQL
SELECT m.title, m.episode, m.current_episode
FROM movie m
INNER JOIN title_type tt ON m.id_title_type = tt.id
WHERE tt.name LIKE 'TV Series'
AND m.current_episode = m.episode;
```
![alt](/image/3.png)

### 4. Liệt kê tên phim và trailer có trạng thái active của phim đó
``` SQL
SELECT m.title AS movie, t.link AS trailer
FROM movie m
INNER JOIN movie_trailer mt ON m.id = mt.id_movie
INNER JOIN trailer t ON mt.id_trailer = t.id
WHERE mt.status LIKE 'active';
```
![alt](/image/4.png)

### 5. Liệt kê tiêu đê, mô tả, poster, độ dài và điểm imdb của các phim thuộc loại Movie và sắp xếp theo điểm imdb giảm dần
```SQL
SELECT title, description, poster, length, imdb
FROM movie ORDER BY imdb DESC;
```

![alt](/image/5.png)

### 6. Liệt kê tiêu đề, mô tả, poster, độ dài, thể loại (bảng genres - trả về dữ liệu dạng array), số tập và số tập đã công chiếu, của các phim thuộc loại TV mini Series, sắp xếp theo ngày công chiếu mới nhất
```SQL
SELECT m.title, m.description, m.poster, m.length, json_arrayagg(g.name) AS genres, m.episode, m.current_episode
FROM movie m 
INNER JOIN movie_genres mg ON m.id = mg.id_movie
INNER JOIN genres g ON mg.id_genres = g.id
INNER JOIN title_type tt ON m.id_title_type = tt.id
WHERE tt.name LIKE 'TV mini Series'
GROUP BY m.id
ORDER BY m.release_date DESC;
```
![alt](/image/6.png)

### 7. Liệt kê tiêu đề, mô tả, đạo diễn, biên kịch (array), poster, độ dài, thể loại (bảng genres - trả về dữ liệu dạng array), tên diễn viên (array) của các phim thuộc loại Movie của 10 bộ phim có điểm imdb cao nhất
```SQL
SELECT m.title, m.description, d.full_name AS director, json_arrayagg(w.full_name) AS writers, m.poster, m.length, json_arrayagg(g.name) AS genres
FROM movie m
INNER JOIN director d ON m.id_director = d.id
INNER JOIN movie_writers mw ON m.id = mw.id_movie
INNER JOIN writers w ON mw.id_writer = w.id
INNER JOIN movie_genres mg ON m.id = mg.id_movie
INNER JOIN genres g ON mg.id_genres = g.id
INNER JOIN movie_actor ma ON m.id = ma.id_movie
INNER JOIN actor a ON a.id = ma.id_actor
GROUP BY m.id
ORDER BY m.imdb DESC 
LIMIT 10;
```

![alt](/image/7.png)
