package com.ch.podo.film.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Pagination;
import com.ch.podo.film.model.service.FilmService;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.film.model.vo.Genre;
import com.ch.podo.like.model.service.LikeService;
import com.ch.podo.like.model.vo.Like;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.ratingFilm.model.service.RatingFilmService;
import com.ch.podo.ratingFilm.model.vo.RatingFilm;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

@Controller
public class FilmController {
	
	@Autowired
	private FilmService filmService;

	@Autowired
	private LikeService likeService;

	@Autowired
	private RatingFilmService ratingFilmService;
	
	@RequestMapping("skFilm.do")
	public ModelAndView searchKeywordFilm(ModelAndView mv, String keyword,
																				@RequestParam(value="currentPage", defaultValue = "1") int currentPage) {
		int listCount = filmService.selectKeywordFilmListCount(keyword);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		pi.setPageLimit(3);
		pi.setBoardLimit(6);
		
		ArrayList<Film> list = filmService.selectKeywordFilmList(keyword, pi);
		mv.addObject("listCount", listCount)
			.addObject("pi", pi)
			.addObject("list", list)
			.setViewName("search/searchAll");
		
		return mv;
	}
	
	@RequestMapping("film.do")
	public String filmPage(Model model) {
		ArrayList<Genre> genre = filmService.selectAllGenreList();
		model.addAttribute("genre", genre);
		return "film/filmPage";
	}
	
	@RequestMapping("sfFilm.do")
	public void searchFilterFilm(HttpServletResponse response, HttpSession session, Film film)
			throws JsonIOException, IOException {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 옵션으로 검색된 영화 목록
		ArrayList<Film> filmList = filmService.selectFilterFilmList(film);
		map.put("film", filmList);
		
		// 사용자가 좋아요한 영화 목록
		HashMap<Integer, Like> likeMap = new HashMap<>();
		if (loginUser != null) {
			likeMap = (HashMap<Integer, Like>)likeService.selectLikedFilmMap(loginUser.getId());
		}
		map.put("like", likeMap);
		
		// 사용자가 평가한 영화 목록
		HashMap<Integer, RatingFilm> ratingMap = new HashMap<>();
		if (loginUser != null) {
			ratingMap = (HashMap<Integer, RatingFilm>)ratingFilmService.selectRatedFilm(loginUser.getId());
		}
		map.put("rate", ratingMap);
		
		response.setContentType("application/json; charset=utf-8");
		Gson gson = new Gson();
		gson.toJson(map, response.getWriter());
	}
	
	@RequestMapping("likeFilm.do")
	public void likeFilm(HttpServletResponse response, HttpSession session, String fid, int flag)
			throws JsonIOException, IOException {
		Member mem = (Member)session.getAttribute("loginUser");
		
		Like like = new Like();
		like.setTargetId(Integer.parseInt(fid));
		like.setUserId(mem.getId());
		
		// System.out.println("fid : " + fid);
		// System.out.println("flag : " + flag);
		
		int result = 0;
		if (flag > 0) {
			result = likeService.insertLikeFilm(like);
		} else {
			result = likeService.deleteLikeFilm(like);
		}
		
		response.setContentType("application/json; charset=utf-8");
		Gson gson = new Gson();
		gson.toJson(result, response.getWriter());
	}
	
	@RequestMapping("rateFilm.do")
	public void rateFilm(HttpServletResponse response, HttpSession session, String fid, String star)
			throws JsonIOException, IOException {
		Member mem = (Member)session.getAttribute("loginUser");
		
		RatingFilm rate = new RatingFilm();
		rate.setStar(Integer.parseInt(star));
		rate.setUserId(mem.getId());
		rate.setFilmId(Integer.parseInt(fid));
		
		RatingFilm flag = ratingFilmService.selectRatingFilm(rate);
		int result = 0;

		// 이미 기존에 있는 별점을 다시 눌렀을 경우 취소되면서 삭제
		if (flag != null && Integer.parseInt(star) == flag.getStar()) {
			result = ratingFilmService.deleteRateFilm(rate);
			System.out.println("delete 실행");
		} else {
			// 기존에 별점이 없다면 삽입
			if (flag == null) {
				result = ratingFilmService.insertRateFilm(rate);
				System.out.println("insert 실행");
			// 이미 기존에 별점이 있다면 수정
			} else {
				result = ratingFilmService.updateLikeFilm(rate);
				System.out.println("update실행");
			}
		}
		
		response.setContentType("application/json; charset=utf-8");
		Gson gson = new Gson();
		gson.toJson(result, response.getWriter());
	}
	
	@RequestMapping("rec.do")
	public ModelAndView rec(HttpSession session, ModelAndView mv,
													@RequestParam(value="page", defaultValue = "1") int page) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		int listCount = 1;
		if (loginUser != null) {
			listCount = filmService.selectLikedFilmCount(loginUser.getId());
		}
		PageInfo pi = Pagination.getPageInfo(page, listCount);
		pi.setPageLimit(3);
		pi.setBoardLimit(5);
		
		
		ArrayList<Film> list = null;
		if (loginUser != null) {
			list = filmService.selectLikedFilmList(loginUser.getId(), pi);
		}
		// System.out.println("liked film list : " + list);
		
		mv.addObject("list", list).addObject("page", page).setViewName("film/rec");
		
		return mv;
	}
	
	@RequestMapping("moreRec.do")
	public void moreRec(HttpSession session, HttpServletResponse response,
											@RequestParam(value="page", defaultValue = "1") int page)
		throws JsonIOException, IOException {
		
		Member loginUser = (Member)session.getAttribute("loginUser");

		HashMap<String, Object> map = new HashMap<>();
		
		// 페이지 계산
		int listCount = 1;
		if (loginUser != null) {
			listCount = filmService.selectLikedFilmCount(loginUser.getId());
		}
		page++;
		PageInfo pi = Pagination.getPageInfo(page, listCount);
		pi.setPageLimit(3);
		pi.setBoardLimit(5);
		
		map.put("page", page);
		
		// RowBounds 포함 좋아요한 영화 목록 조회 AJAX
		ArrayList<Film> list = null;
		if (loginUser != null) {
			list = filmService.selectLikedFilmList(loginUser.getId(), pi);
		}
		// System.out.println("liked film list : " + list);
		map.put("list", list);

		response.setContentType("application/json; charset=utf-8");
		Gson gson = new Gson();
		gson.toJson(map, response.getWriter());
	}
	
}
