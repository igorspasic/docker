package com.oblac;

import jodd.util.SystemUtil;
import java.io.File;
import java.text.DecimalFormat;

public class Print {

	public static void javaVersion() {
		System.out.println("Java version: " + SystemUtil.javaVersion());
	}

	public static void system() {
		/* Total number of processors or cores available to the JVM */
		System.out.println("Available processors (cores): " +
			Runtime.getRuntime().availableProcessors());

		/* Total amount of free memory available to the JVM */
		System.out.println("Free memory: " +
			readableSize(Runtime.getRuntime().freeMemory()));

		/* This will return Long.MAX_VALUE if there is no preset limit */
		long maxMemory = Runtime.getRuntime().maxMemory();

		/* Maximum amount of memory the JVM will attempt to use */
		System.out.println("Maximum memory: " +
			(maxMemory == Long.MAX_VALUE ? "no limit" : readableSize(maxMemory)));

		/* Total memory currently in use by the JVM */
		System.out.println("Total memory: " +
			readableSize(Runtime.getRuntime().totalMemory()));

		/* Get a list of all filesystem roots on this system */
		File[] roots = File.listRoots();

		/* For each filesystem root, print some info */
		for (File root : roots) {
			System.out.println("File system root: " + root.getAbsolutePath());
			System.out.println("Total space: " + readableSize(root.getTotalSpace()));
			System.out.println("Free space: " + readableSize(root.getFreeSpace()));
			System.out.println("Usable space: " + readableSize(root.getUsableSpace()));
		}
	}

	public static void line() {
		System.out.println("------------------------------------------------------");
	}

	public static void message(String str) {
		System.out.println(str);
	}

	public static String readableSize(long size) {
		if(size <= 0) {
			return "0";
		}
		final String[] units = new String[] { "B", "kB", "MB", "GB", "TB" };
		int digitGroups = (int) (Math.log10(size)/Math.log10(1024));
		return new DecimalFormat("#,##0.#").format(size/Math.pow(1024, digitGroups)) + " " + units[digitGroups];
	}
}
