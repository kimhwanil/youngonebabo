package com.spring.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.BoardVO;
import com.spring.domain.PageMaker;
import com.spring.domain.SerarchCriteria;
import com.spring.service.BoardService;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {
	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);

	@Inject
	private BoardService service;
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SerarchCriteria cri, Model model) throws Exception{
		logger.info(cri.toString());
		model.addAttribute("list", service.listSearchCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		model.addAttribute("pageMaker", pageMaker);//sboard/list.jsp
	}
	@RequestMapping(value="/readPage", method=RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") SerarchCriteria cri, Model model) throws Exception{
		model.addAttribute(service.read(bno));//readPage.jsp
	}
	
	@RequestMapping(value="/removePage", method=RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, SerarchCriteria cri, RedirectAttributes rttr )throws Exception{
		service.remove(bno);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		rttr.addAttribute("msg","delSUCCESS");
		return "redirect:/sboard/list";
		
	}
	@RequestMapping(value="/modifyPage", method=RequestMethod.GET)
	public void modifyPagingGET( int bno, @ModelAttribute("cri") SerarchCriteria cri, Model model) throws Exception{
		model.addAttribute(service.read(bno));//modifyPage.jsp
	}
    
	@RequestMapping(value="/modifyPage", method=RequestMethod.POST)
	public String modifyPagingPOST(BoardVO board, SerarchCriteria cri, RedirectAttributes rttr )throws Exception{
		logger.info(cri.toString());
		service.modify(board);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		rttr.addAttribute("msg","modSUCCESS");
		logger.info(rttr.toString());
		return "redirect:/sboard/list";	
	}
	
	 @RequestMapping(value="/register",method=RequestMethod.GET)
	   public void registGET() throws Exception{ //  "/board/register"
		   logger.info("regist_GET()......");
		   //return 생략: register.jsp이동
	   }
	//   @RequestMapping(value="/register",method=RequestMethod.POST)
	//   public String registerPOST(BoardVO vo, Model model) throws Exception{ //  "/board/register"
//		   logger.info("register_POST()......");
//		   logger.info(vo.toString());
//		   service.regist(vo);//insert
//		  model.addAttribute("result", "success~~~~~~~~~~~");
//		//return "/board/success";
//		  return "redirect:/board/listAll";
	//   }
	   @RequestMapping(value="/register",method=RequestMethod.POST)
	   public String registPOST(BoardVO vo, RedirectAttributes rttr) throws Exception{ //  "/board/register"
		   logger.info("regist_POST()......");
		   logger.info(vo.toString());
		   service.regist(vo);//insert
		   rttr.addFlashAttribute("msg","regSUCCESS");
		   return "redirect:/sboard/list";
	   }
	   //추가
	   @RequestMapping("/getAttach/{bno}")
	   @ResponseBody
	   public List<String> getAttach(@PathVariable("bno")Integer bno)throws Exception{
	     
	     return service.getAttach(bno);
	   }  
}









