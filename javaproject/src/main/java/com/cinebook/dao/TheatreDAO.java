package com.cinebook.dao;

import com.cinebook.model.Theatre;
import com.cinebook.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TheatreDAO {

    public List<Theatre> getAllTheatres() {
        List<Theatre> list = new ArrayList<>();
        String sql = "SELECT id, name, city, address FROM theatres ORDER BY name ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToTheatre(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Theatre getTheatreById(int id) {
        String sql = "SELECT id, name, city, address FROM theatres WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTheatre(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Theatre mapResultSetToTheatre(ResultSet rs) throws SQLException {
        Theatre theatre = new Theatre();
        theatre.setId(rs.getInt("id"));
        theatre.setName(rs.getString("name"));
        theatre.setCity(rs.getString("city"));
        theatre.setAddress(rs.getString("address"));
        return theatre;
    }
}
