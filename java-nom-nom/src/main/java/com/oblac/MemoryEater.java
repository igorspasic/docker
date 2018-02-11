package com.oblac;

import jodd.util.ThreadUtil;
import java.util.ArrayList;
import java.util.List;

public class MemoryEater {

	private final static List<byte[]> hog = new ArrayList<>();

	public static void main(String[] args) {
		Print.line();

		Print.javaVersion();

		Print.line();

		Print.system();

		Print.line();

		for (int i = 0; i < 20; i++) {
			Print.message("Eat 100 Mb");
			eatMemory(100);
			Print.message("Nom");
			ThreadUtil.sleep(100);
		}

		Print.line();

		Print.system();
	}

	public static void eatMemory(int sizeInMegabytes) {
		hog.add(new byte[sizeInMegabytes * 1_000_000]);
	}

}