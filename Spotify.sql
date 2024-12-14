use spotify;

select * from spotify;

/*
Q1) What are the top 10 tracks with the highest number of streams?
Q2) Which artist has the most tracks in the dataset, and how many tracks do they have?
Q3) How many tracks were released each year?
Q4) What percentage of tracks are included in Spotify, Apple, and Deezer playlists?
Q5) What is the average BPM (beats per minute) of tracks released in each year?
Q6) What are the Top 5 Most Streamed Tracks Released in Each Year?
Q7) How many tracks are classified as major vs. minor mode?
Q8) Which tracks have consistently appeared in the top charts across Spotify, Apple, and Deezer?
Q9) What is the average energy level of tracks by artist?
Q10) How has the average energy level of tracks changed from year to year?
*/

-- Q1)  What are the top 10 tracks with the highest number of streams?

SELECT track_name, artist_name, streams FROM SPOTIFY 
ORDER BY streams DESC
LIMIT 10;

-- Q2) Which artist has the most tracks in the dataset, and how many tracks do they have?

SELECT artist_name, count(track_name) AS Total_Tracks FROM SPOTIFY
GROUP BY artist_name
ORDER BY count(track_name) DESC
LIMIT 1;

-- Q3) How many tracks were released each year?

SELECT released_year, count(track_name) AS Total_Tracks FROM SPOTIFY
GROUP BY released_year
ORDER BY released_year DESC;

-- Q4)  What percentage of tracks are included in Spotify, Apple, and Deezer playlists?

SELECT
	ROUND((SUM(spotify_playlists) / COUNT(spotify_playlists)) * 100, 2) AS `Spotify_%`,
    ROUND((SUM(apple_playlists) / COUNT(apple_playlists)) * 100, 2) AS `Apple_%`,
    ROUND((SUM(deezer_playlists) / COUNT(deezer_playlists)) * 100, 2) AS `Deezer_%`
FROM spotify;

-- Q5) What is the average BPM (beats per minute) of tracks released in each year?

SELECT released_year, avg(bpm) as Avg_BPM FROM spotify
GROUP BY released_year
ORDER BY released_year desc;

-- Q6) What are the Top 5 Most Streamed Tracks Released in Each Year? NOT WORKING!!


SELECT s1.track_name, s1.artist_name, s1.streams, s1.released_year
FROM spotify s1
WHERE (
    SELECT COUNT(*) 
    FROM spotify s2
    WHERE s2.released_year = s1.released_year AND s2.streams > s1.streams
) < 5
ORDER BY s1.released_year DESC, s1.streams DESC;

-- Q7) How many tracks are classified as major vs. minor mode?

SELECT mode, count(mode) as Total_Mode FROM spotify
GROUP BY mode
ORDER BY count(mode) DESC;

-- Q8) Which tracks have consistently appeared in the top charts across Spotify, Apple, and Deezer?

SELECT track_name, artist_name FROM spotify
WHERE track_name in (spotify_charts AND apple_charts AND deezer_charts);

SELECT track_name, artist_name FROM spotify
WHERE track_name in (spotify_charts , apple_charts, deezer_charts);

-- Q9) What is the average energy level of tracks by artist? 

SELECT artist_name,AVG(`energy_%`) as Avg_Energy_Level from spotify
GROUP BY artist_name;

-- Q10) How has the average energy level of tracks changed from year to year?  

SELECT released_year, AVG(`energy_%`) AS Avg_Energy_Level FROM spotify 
GROUP BY released_year 
ORDER BY released_year ASC;