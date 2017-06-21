package com.banggo.scheduler.common;

import java.io.Serializable;

/**
 * 分页器
 * 
 * @author
 * 
 */
public class Paginator implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2018436532193281591L;

	public static final int DEFAULT_ITEMS_PER_PAGE = 20;
	public static final int DEFAULT_SLIDER_SIZE = 7;
	public static final int UNKNOWN_ITEMS = Integer.MAX_VALUE;
	private int page;
	private int items;
	private int itemsPerPage;

	public Paginator() {
		this(0);
	}

	public Paginator(int itemsPerPage) {
		this(itemsPerPage, UNKNOWN_ITEMS);
	}

	public Paginator(int itemsPerPage, int items) {
		this.items = (items >= 0 ? items : 0);
		this.itemsPerPage = (itemsPerPage > 0 ? itemsPerPage : 20);
		this.page = calcPage(0);
	}

	/**
	 * 得到总页数
	 * 
	 * @return
	 */
	public int getPages() {
		return (int) Math
				.ceil((double) this.items / (double) this.itemsPerPage);
	}

	/**
	 * 得到当前页
	 * 
	 * @return
	 */
	public int getPage() {
		return this.page;
	}

	/**
	 * 设置当前页
	 * 
	 * @param page
	 * @return
	 */
	public int setPage(int page) {
		return this.page = calcPage(page);
	}

	/**
	 * 得到总记录数
	 * 
	 * @return
	 */
	public int getItems() {
		return this.items;
	}

	/**
	 * 设置总记录数
	 * 
	 * @return
	 */
	public int setItems(int items) {
		this.items = (items >= 0 ? items : 0);
		return this.items;
	}

	/**
	 * 得到每页显示记录数
	 * 
	 * @return
	 */
	public int getItemsPerPage() {
		return this.itemsPerPage;
	}

	/**
	 * 设置每页显示记录数
	 * 
	 * @param itemsPerPage
	 * @return
	 */
	public int setItemsPerPage(int itemsPerPage) {
		this.itemsPerPage = (itemsPerPage > 0 ? itemsPerPage : 20);
		return this.itemsPerPage;
	}

	/**
	 * 得到分页记录的开始下标
	 * 
	 * @return
	 */
	public int getOffset() {
		return this.page > 0 ? this.itemsPerPage * (this.page - 1) : 0;
	}

	public int getLength() {
		if (this.page > 0) {
			return Math.min(this.itemsPerPage * this.page, this.items)
					- this.itemsPerPage * (this.page - 1);
		}
		return 0;
	}

	public int getBeginIndex() {
		if (this.page > 0) {
			return this.itemsPerPage * (this.page - 1) + 1;
		}
		return 0;
	}

	public int getEndIndex() {
		if (this.page > 0) {
			return Math.min(this.itemsPerPage * this.page, this.items);
		}
		return 0;
	}

	/**
	 * 以当前记录的下标设置分页
	 * 
	 * @param itemOffset
	 * @return
	 */
	public int setItem(int itemOffset) {
		return setPage(itemOffset / this.itemsPerPage + 1);
	}

	/**
	 * 得到首页
	 * 
	 * @return
	 */
	public int firstPage() {
		return calcPage(1);
	}

	/**
	 * 得到尾页
	 * 
	 * @return
	 */
	public int lastPage() {
		return calcPage(getPages());
	}

	/**
	 * 前一页
	 * 
	 * @return
	 */
	public int previousPage() {
		return calcPage(this.page - 1);
	}

	/**
	 * 前N页
	 * 
	 * @param n
	 * @return
	 */
	public int previousPage(int n) {
		return calcPage(this.page - n);
	}

	/**
	 * 后一页
	 * 
	 * @return
	 */
	public int nextPage() {
		return calcPage(this.page + 1);
	}

	/**
	 * 后N页
	 * 
	 * @param n
	 * @return
	 */
	public int nextPage(int n) {
		return calcPage(this.page + n);
	}

	/**
	 * 是否可用
	 * 
	 * @param page
	 * @return
	 */
	public boolean enablePage(int page) {
		return (page < 1) || (page > getPages()) || (page == this.page);
	}

	/**
	 * 序列器
	 * 
	 * @return
	 */
	public int[] slider() {
		return slider(DEFAULT_SLIDER_SIZE);
	}

	/**
	 * 序列器
	 * 
	 * @return
	 */
	public int[] slider(int width) {
		int pages = getPages();

		if ((pages < 1) || (width < 1)) {
			return new int[0];
		}
		if (width > pages) {
			width = pages;
		}

		int[] slider = new int[width];
		int first = this.page - (width - 1) / 2;

		if (first < 1) {
			first = 1;
		}

		if (first + width - 1 > pages) {
			first = pages - width + 1;
		}

		for (int i = 0; i < width; i++) {
			slider[i] = (first + i);
		}

		return slider;
	}

	/**
	 * 计算分页
	 * 
	 * @param page
	 * @return
	 */
	protected int calcPage(int page) {
		int pages = getPages();

		if (pages > 0) {
			return page > pages ? pages : page < 1 ? 1 : page;
		}

		return 0;
	}

}